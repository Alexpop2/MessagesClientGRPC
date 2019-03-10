//
//  MCAuthorizationData.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public struct MCAuthorizationData {
    public let firebaseToken: String
    
    public init(firebaseToken: String) {
        self.firebaseToken = firebaseToken
    }
}

public struct MCAuthorizationResult {
    public let data: String
    public let token: MCPerformMessageToken
    public let userID: String
    
    public init(data: String, token: MCPerformMessageToken, userID: String) {
        self.data = data
        self.token = token
        self.userID = userID
    }
}
