//
//  MessageService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

class MessageService {
    
    private var messageClient: Messageservice_MessageServiceServiceClient?
    private var messageStreamCall: Messageservice_MessageServicePerformMessageStreamCall?
    
    private let connectionQueue = DispatchQueue(label: "connectionQueue")
    private let loadMessageQueue = OperationQueue()
    private let tryConnectionQueue = OperationQueue()
    
    private var connectionState = true
    private var userID = ""
    private var nickName = ""
    private var login = ""
    private var token = ""
    
    private var receivedTokenClosure: (String) -> Void
    
    public init(address: String,
                caCertificate: String,
                clientCertificate: String,
                clientKey: String,
                sslDomain: String,
                receivedTokenClosure: @escaping (String) -> Void) {
        self.receivedTokenClosure = receivedTokenClosure
        let arguments: [Channel.Argument] = [.sslTargetNameOverride(sslDomain)]
        messageClient =  Messageservice_MessageServiceServiceClient(address: address,
                                                                    certificates: caCertificate,
                                                                    clientCertificates: clientCertificate,
                                                                    clientKey: clientKey,
                                                                    arguments: arguments)
    }
    
}
extension MessageService: IMessageService {
    
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void) {
        messageClient?.channel.addConnectivityObserver(callback: callback)
    }
    
    public func send(message: MCMessage, completion: @escaping (CallResult?) -> Void) {
        var mcMessage = message.message
        mcMessage.sender.id = self.userID
        mcMessage.sender.nickName = self.nickName
        mcMessage.token = self.token
        do {
            _ = try messageClient?.send(mcMessage, completion: { (state, result) in
                DispatchQueue.main.async {
                    completion(result)
                }
            })
        } catch {
            completion(nil)
        }
    }
    
    func verifyGet(message: MCMessage, completion: @escaping (CallResult?) -> Void) {
        do {
            _ = try messageClient?.verifyGet(message.message, completion: { (state, result) in
                DispatchQueue.main.async {
                    completion(result)
                }
            })
        } catch {
            completion(nil)
        }
    }
    
    public func performMessageStream(data: MCPerformMessageData, completion: @escaping (MCMessage) -> Void) {
        self.loadMessageQueue.cancelAllOperations()
        self.tryConnectionQueue.cancelAllOperations()
        self.messageStreamCall?.cancel()
        
        self.login = data.phone
        self.token = data.messageClientToken.data
        self.userID = data.userID
        self.nickName = data.userNickName
        
        receivedTokenClosure(data.messageClientToken.data)
        
        connectionQueue.async {
            
            // TODO: Solve problem with silent closing connection
            
            var messageDisconnect = Messageservice_Message()
            messageDisconnect.id = "-1"
            messageDisconnect.text = "Couldn't connect"
            
            if(!self.connectionState) {
                self.tryConnectionQueue.addOperation(TryConnectionOperation(messageClient: self.messageClient,
                                                                            completion: { message in
                                                                                completion(MCMessage(GRPCMessage: message)) },
                                                                            setConnectionStateTrue: {
                                                                                self.connectionState = true
                                                                                self.performMessageStream(data: data,
                                                                                                          completion: completion)
                }))
            } else {
                do {
                    guard let metadata = self.messageClient?.metadata else { return }
                    
                    let messageStream = try self.messageClient?.performMessageStream(metadata: metadata,
                                                                                     completion: { (call) in
                    })
                    self.messageStreamCall = messageStream
                    var request = Messageservice_MessageStreamRequest();
                    request.login = self.login
                    request.token = self.token
                    do {
                        _ = try messageStream?.send(request)
                        self.connectionState = true
                        self.loadMessageQueue.addOperation(LoadMessageOperation(login: self.login,
                                                                                token: self.token,
                                                                                messageStream: messageStream,
                                                                                userID: self.userID,
                                                                                completion: { message in
                                                                                    completion(MCMessage(GRPCMessage: message)) },
                                                                                messageService: self))
                    } catch {
                        self.connectionState = false
                        DispatchQueue.main.async {
                            completion(MCMessage(GRPCMessage: messageDisconnect))
                        }
                        self.performMessageStream(data: data, completion: completion)
                    }
                } catch {
                    self.connectionState = false
                    DispatchQueue.main.async {
                        completion(MCMessage(GRPCMessage: messageDisconnect))
                    }
                    self.performMessageStream(data: data, completion: completion)
                }
            }
            
            
        }
    }
    
}
