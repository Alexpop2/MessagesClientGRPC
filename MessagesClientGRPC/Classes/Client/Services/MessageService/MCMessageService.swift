//
//  MessageService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

class MCMessageService {
    
    private var messageClient: Messageservice_MessageServiceServiceClient?
    private var messageStreamCall: Messageservice_MessageServicePerformMessageStreamCall?
    
    private let connectionQueue = DispatchQueue(label: "connectionQueue")
    private let loadMessageQueue = OperationQueue()
    
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
extension MCMessageService: IMCMessageService {
    
    func getCurrentConnectionState(callback: @escaping (Channel.ConnectivityState) -> Void) {
        guard let client = messageClient else { return }
        callback(client.channel.connectivityState())
    }
    
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void) {
        messageClient?.channel.addConnectivityObserver(callback: callback)
    }
    
    public func send(message: MCMessage, completion: @escaping (CallResult?) -> Void) {
        var mcMessage = message.message
        mcMessage.phone = self.login
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
        self.messageStreamCall?.cancel()
        
        self.login = data.phone
        self.token = data.messageClientToken.data
        
        receivedTokenClosure(data.messageClientToken.data)
        
        connectionQueue.async {
        
            // TODO: Solve problem with silent closing connection
            
            var messageDisconnect = Messageservice_Message()
            messageDisconnect.id = "-1"
            messageDisconnect.text = "Couldn't connect"
            messageDisconnect.code = 201
        

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
                    //self.connectionState = true
                    self.loadMessageQueue.addOperation(LoadMessageOperation(login: self.login,
                                                                            token: self.token,
                                                                            messageStream: messageStream,
                                                                            completion: { message in
                                                                                completion(MCMessage(GRPCMessage: message)) },
                                                                            messageService: self))
                } catch {
                    //self.connectionState = false
                    DispatchQueue.main.async {
                        completion(MCMessage(GRPCMessage: messageDisconnect))
                    }
                    self.performMessageStream(data: data, completion: completion)
                }
            } catch {
                //self.connectionState = false
                DispatchQueue.main.async {
                    completion(MCMessage(GRPCMessage: messageDisconnect))
                }
                self.performMessageStream(data: data, completion: completion)
            }
            
        }

    }
    
}
