//
//  AuthService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

class MCAuthService {
    
    private var authorizationClient: Authorizationservice_AuthorizationServiceServiceClient?
    private var authorizationCall: Authorizationservice_AuthorizationServiceAuthorizeCall?
    
    init(address: String, caCertificate: String, clientCertificate: String, clientKey: String, sslDomain: String) {
        let arguments: [Channel.Argument] = [.sslTargetNameOverride(sslDomain)]
        authorizationClient =  Authorizationservice_AuthorizationServiceServiceClient(address: address,
                                                                                      certificates: caCertificate,
                                                                                      clientCertificates: clientCertificate,
                                                                                      clientKey: clientKey,
                                                                                      arguments: arguments)
    }
    
}

extension MCAuthService: IMCAuthService {
    
    func getCurrentConnectionState(callback: @escaping (Channel.ConnectivityState) -> Void) {
        guard let client = authorizationClient else { return }
        callback(client.channel.connectivityState())
    }
    
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void) {
        authorizationClient?.channel.addConnectivityObserver(callback: callback)
    }
    
    func authorize(with token: MCFirebaseToken, completion: @escaping (MCAuthorizationResult?, CallResult?) -> Void) {
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
    
}
