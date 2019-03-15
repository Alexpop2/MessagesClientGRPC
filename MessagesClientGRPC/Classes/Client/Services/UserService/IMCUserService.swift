//
//  IUserService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public protocol IMCUserService: IMCNetworkService {
    func setUserName(token: String, name: String, completion: @escaping (CallResult?) -> Void)
    func getUserBy(phone: String, completion: @escaping (MCUser?, CallResult?) -> Void)
    func getUserBy(id: String, completion: @escaping (MCUser?, CallResult?) -> Void)
    func getUserBy(name: String, completion: @escaping (MCUser?, CallResult?) -> Void)
    func getKnownRegisteredUsersBy(phones: [String], completion: @escaping ([MCUser], CallResult?) -> Void)
}
