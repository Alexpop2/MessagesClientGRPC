//
//  NetworkingClient.swift
//  NetworkingClient
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public enum NetworkingClientError: Int {
    case OK = 200
    case FailedConnect = 201
    case Disconnected = 202
    case MessageReceivedOK = 1000
    case UserNotFound = 404
    case InvalidToken = 403
    case Unrecognized = 0
}

public class NetworkingClient {
    
    public let userService: IMCUserService
    public let authService: IMCAuthService
    public let messageService: IMCMessageService
    
    private var monitor: ClientNetworkMonitor?
    private var address: String
    
    public static var shared: NetworkingClient!
    public var networkReachability: Bool? { return monitor?.isReachable }
    
    private var stateChanged: ((ClientNetworkMonitor.State) -> Void)?
    
    private init(address: String, caCertificate: String, clientCertificate: String, clientKey: String, sslDomain: String) {
        
        self.address = address
        let userService = MCUserService(address: address,
                                        caCertificate: caCertificate,
                                        clientCertificate: clientCertificate,
                                        clientKey: clientKey,
                                        sslDomain: sslDomain)
        let authService = MCAuthService(address: address,
                                        caCertificate: caCertificate,
                                        clientCertificate: clientCertificate,
                                        clientKey: clientKey,
                                        sslDomain: sslDomain)
        let messageService = MCMessageService(address: address,
                                              caCertificate: caCertificate,
                                              clientCertificate: clientCertificate,
                                              clientKey: clientKey,
                                              sslDomain: sslDomain,
                                              receivedTokenClosure: { token in userService.setToken(token: token) })
        
        self.userService = userService
        self.authService = authService
        self.messageService = messageService
        
        monitor = ClientNetworkMonitor(host: address, queue: nil, callback: { (state) in
            self.stateChanged?(state)
        })
    }
    
    public static func configure(address: String,
                                 caCertificate: String,
                                 clientCertificate: String,
                                 clientKey: String,
                                 sslDomain: String) {
        NetworkingClient.shared = NetworkingClient(address: address,
                                                   caCertificate: caCertificate,
                                                   clientCertificate: clientCertificate,
                                                   clientKey: clientKey,
                                                   sslDomain: sslDomain)
    }
    
    public func configureStateCallback(completion: @escaping (ClientNetworkMonitor.State) -> Void) {
        stateChanged = completion
    }
    
    
    
}
