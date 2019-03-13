//
//  UserService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

class UserService {
    
    private var usersClient: Userservice_UserServiceServiceClient?
    
    private var token = ""
    
    init(address: String, caCertificate: String, clientCertificate: String, clientKey: String, sslDomain: String) {
        let arguments: [Channel.Argument] = [.sslTargetNameOverride(sslDomain)]
        usersClient = Userservice_UserServiceServiceClient(address: address,
                                                           certificates: caCertificate,
                                                           clientCertificates: clientCertificate,
                                                           clientKey: clientKey,
                                                           arguments: arguments)
    }
    
    func setToken(token: String) {
        self.token = token
    }
    
}

extension UserService: IUserService {
    
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void) {
        usersClient?.channel.addConnectivityObserver(callback: callback)
    }
    
    func setUserName(name: String, completion: @escaping (CallResult?) -> Void) {
        
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
    
    func getUserBy(phone: String, completion: @escaping (MCUser?, CallResult?) -> Void) {
        
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
    
    func getUserBy(id: String, completion: @escaping (MCUser?, CallResult?) -> Void) {
        
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
    
    func getUserBy(name: String, completion: @escaping (MCUser?, CallResult?) -> Void) {
        
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
    
    func getKnownRegisteredUsersBy(phones: [String], completion: @escaping ([MCUser], CallResult?) -> Void) {
        
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
}
