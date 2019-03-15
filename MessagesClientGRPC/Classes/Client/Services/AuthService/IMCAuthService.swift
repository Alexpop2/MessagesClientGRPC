//
//  IAuthService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public protocol IMCAuthService: IMCNetworkService {
    func authorize(with token: MCFirebaseToken, completion: @escaping (MCAuthorizationResult?, CallResult?) -> Void)
}
