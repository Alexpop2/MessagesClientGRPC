//
//  MCPerformMessageData.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public struct MCPerformMessageToken {
    public let data: String
    
    public init(data: String) {
        self.data = data
    }
}

public struct MCPerformMessageData {
    public let phone: String
    public let messageClientToken: MCPerformMessageToken
    
    public init(phone: String, messageClientToken: MCPerformMessageToken) {
        self.phone = phone
        self.messageClientToken = messageClientToken
    }
}
