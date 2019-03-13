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
    
    private var messageClient: Messageservice_MessageServiceServiceClient?
    private var authorizationClient: Authorizationservice_AuthorizationServiceServiceClient?
    private var usersClient: Userservice_UserServiceServiceClient?
    
    private var connectionState = true
    
    private let loadMessageQueue = OperationQueue()
    private let tryConnectionQueue = OperationQueue()
    private let connectionQueue = DispatchQueue(label: "connectionQueue")
    
    private var authorizationCall: Authorizationservice_AuthorizationServiceAuthorizeCall?
    private var messageStreamCall: Messageservice_MessageServicePerformMessageStreamCall?
    
    private var userID = ""
    private var nickName = ""
    private var login = ""
    private var token = ""
    
    public init(address: String, caCertificate: String, clientCertificate: String, clientKey: String, sslDomain: String) {
        
        let arguments: [Channel.Argument] = [.sslTargetNameOverride(sslDomain)]
        messageClient =  Messageservice_MessageServiceServiceClient(address: address,
                                                                    certificates: caCertificate,
                                                                    clientCertificates: clientCertificate,
                                                                    clientKey: clientKey,
                                                                    arguments: arguments)
        authorizationClient =  Authorizationservice_AuthorizationServiceServiceClient(address: address,
                                                                                      certificates: caCertificate,
                                                                                      clientCertificates: clientCertificate,
                                                                                      clientKey: clientKey,
                                                                                      arguments: arguments)
        usersClient = Userservice_UserServiceServiceClient(address: address,
                                                           certificates: caCertificate,
                                                           clientCertificates: clientCertificate,
                                                           clientKey: clientKey,
                                                           arguments: arguments)
        
        //messageClient = Messageservice_MessageServiceServiceClient.init(address: address, secure: false)
        //authorizationClient = Authorizationservice_AuthorizationServiceServiceClient.init(address: address, secure: false)
        
    }
    
    public func setUserName(name: String, completion: @escaping (CallResult?) -> Void) {
        
        var userName = Userservice_Name();
        userName.data = name
        userName.token = self.token
        
        do {
            _ = try usersClient?.setUserName(userName, completion: { (empty, result) in
                completion(result)
            })
        } catch {
            completion(nil)
        }
    }
    
    public func getUserBy(phone: String, completion: @escaping (MCUser?, CallResult?) -> Void) {
        
        var servicePhone = Userservice_Phone();
        servicePhone.data = phone
        servicePhone.token = self.token
        
        do {
            _ = try usersClient?.getUserByPhone(servicePhone, completion: { (user, callResult) in
                guard let userUnwrapped = user else {
                    completion(nil, callResult)
                    return }
                completion(MCUser(id: userUnwrapped.id, name: userUnwrapped.name, phone: userUnwrapped.phone),callResult)
            })
        } catch {
            completion(nil, nil)
        }
    }
    
    public func getUserBy(id: String, completion: @escaping (MCUser?, CallResult?) -> Void) {
        
        var servicePhone = Userservice_ID();
        servicePhone.data = id
        servicePhone.token = self.token
        
        do {
            _ = try usersClient?.getUserByID(servicePhone, completion: { (user, callResult) in
                guard let userUnwrapped = user else {
                    completion(nil, callResult)
                    return }
                completion(MCUser(id: userUnwrapped.id, name: userUnwrapped.name, phone: nil),callResult)
            })
        } catch {
            completion(nil, nil)
        }
    }
    
    public func getUserBy(name: String, completion: @escaping (MCUser?, CallResult?) -> Void) {
        
        var servicePhone = Userservice_Name();
        servicePhone.data = name
        servicePhone.token = self.token
        
        do {
            _ = try usersClient?.getUserByName(servicePhone, completion: { (user, callResult) in
                guard let userUnwrapped = user else {
                    completion(nil, callResult)
                    return }
                completion(MCUser(id: userUnwrapped.id, name: userUnwrapped.name, phone: nil),callResult)
            })
        } catch {
            completion(nil, nil)
        }
    }
    
    public func getKnownRegisteredUsersBy(phones: [String], completion: @escaping ([MCUser], CallResult?) -> Void) {
        
        var servicePhones = Userservice_Phones();
        servicePhones.phones = phones
        servicePhones.token = self.token
        do {
            _ = try usersClient?.getKnownRegisteredUsersByPhones(servicePhones, completion: { (users, callResult) in
                guard let usersUnwrapped = users else {
                    completion([], callResult)
                    return
                }
                var users = [MCUser]()
                for user in usersUnwrapped.users {
                    users.append(MCUser(id: user.id, name: user.name, phone: user.phone))
                }
                completion(users, callResult)
            })
        } catch {
            completion([], nil)
        }
    }
    
    public func authorize(with token: MCFirebaseToken, completion: @escaping (MCAuthorizationResult?, CallResult?) -> Void) {
        var firebaseToken = Authorizationservice_FirebaseToken()
        firebaseToken.data = token.data
        authorizationCall?.cancel()
        do {
            authorizationCall = try self.authorizationClient?.authorize(firebaseToken, completion: { (result, callResult) in
                guard let result = result else {
                    let authResult = MCAuthorizationResult(data: "Result is nil", token: MCFirebaseCustomToken(data: ""), userID: "")
                    completion(authResult, callResult)
                    return
                }
                let authResult = MCAuthorizationResult(data: result.data,
                                                       token: MCFirebaseCustomToken(data: result.token.data),
                                                       userID: result.userID)
                completion(authResult,callResult)
                return
            })
        } catch {
            let authResult = MCAuthorizationResult(data: "Authorize call error", token: MCFirebaseCustomToken(data: ""), userID: "")
            completion(authResult, nil)
            return
        }
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
