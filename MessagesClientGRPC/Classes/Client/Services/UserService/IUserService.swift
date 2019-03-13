//
//  IUserService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public protocol IUserService {
    func setUserName(name: String, completion: @escaping (CallResult?) -> Void)
    func getUserBy(phone: String, completion: @escaping (MCUser?, CallResult?) -> Void)
    func getUserBy(id: String, completion: @escaping (MCUser?, CallResult?) -> Void)
    func getUserBy(name: String, completion: @escaping (MCUser?, CallResult?) -> Void)
    func getKnownRegisteredUsersBy(phones: [String], completion: @escaping ([MCUser], CallResult?) -> Void)
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void)
}
