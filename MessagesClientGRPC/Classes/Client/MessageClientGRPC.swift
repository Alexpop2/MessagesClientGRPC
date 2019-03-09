//
//  MessageClientGRPC.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public class MessagesClientGRPC {
    
    private let messageClient = Messageservice_MessageServiceServiceClient
        .init(address: "185.22.232.125:50051", secure: false)
    private let authorizationClient = Authorizationservice_AuthorizationServiceServiceClient
        .init(address: "185.22.232.125:50051", secure: false)
    
    private var connectionState = true
    
    private let loadMessageQueue = OperationQueue()
    private let tryConnectionQueue = OperationQueue()
    private let connectionQueue = DispatchQueue(label: "connectionQueue")
    
    private var authorizationCall: Authorizationservice_AuthorizationServiceAuthorizeCall?
    private var messageStreamCall: Messageservice_MessageServicePerformMessageStreamCall?
    
    private var login = ""
    private var token = ""
    
    public init() {}
    
    public func authorize(with authData: MCAuthorizationData, completion: @escaping (MCAuthorizationResult?, CallResult?) -> Void) {
        var firebaseToken = Authorizationservice_FirebaseToken()
        firebaseToken.data = authData.firebaseToken
        authorizationCall?.cancel()
        do {
            authorizationCall = try self.authorizationClient.authorize(firebaseToken, completion: { (result, callResult) in
                guard let result = result else {
                    let authResult = MCAuthorizationResult(data: "Result is nil", token: MCPerformMessageToken(data: ""))
                    completion(authResult, callResult)
                    return
                }
                let authResult = MCAuthorizationResult(data: result.data, token: MCPerformMessageToken(data: result.token.data))
                completion(authResult,callResult)
            })
        } catch {
            let authResult = MCAuthorizationResult(data: "Authorize call error", token: MCPerformMessageToken(data: ""))
            completion(authResult, nil)
        }
    }
    
    public func send(message: MCMessage, completion: @escaping (CallResult?) -> Void) {
        var mcMessage = message.message
        mcMessage.senderID = self.login
        mcMessage.token = self.token
        do {
            _ = try messageClient.send(mcMessage, completion: { (state, result) in
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
            _ = try messageClient.verifyGet(message.message, completion: { (state, result) in
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
                    let messageStream = try self.messageClient.performMessageStream(metadata: self.messageClient.metadata,
                                                                                    completion: { (call) in
                    })
                    self.messageStreamCall = messageStream
                    var request = Messageservice_MessageStreamRequest();
                    request.login = self.login
                    request.token = self.token
                    do {
                        _ = try messageStream.send(request)
                        self.connectionState = true
                        self.loadMessageQueue.addOperation(LoadMessageOperation(login: self.login,
                                                                                token: self.token,
                                                                                messageStream: messageStream,
                                                                                completion: { message in
                                                                                    completion(MCMessage(GRPCMessage: message)) },
                                                                                messageClientGRPC: self))
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
