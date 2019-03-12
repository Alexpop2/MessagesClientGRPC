//
//  MCAuthorizationData.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public struct MCFirebaseToken {
    public let data: String
    
    public init(data: String) {
        self.data = data
    }
}

public struct MCFirebaseCustomToken {
    public let data: String
    
    public init(data: String) {
        self.data = data
    }
}

public struct MCAuthorizationResult {
    public let data: String
    public let token: MCFirebaseCustomToken
    public let userID: String
    
    init(data: String, token: MCFirebaseCustomToken, userID: String) {
        self.data = data
        self.token = token
        self.userID = userID
    }
}
