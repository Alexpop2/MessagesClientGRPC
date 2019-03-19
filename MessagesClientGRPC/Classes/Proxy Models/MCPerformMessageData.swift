//
//  MCPerformMessageData.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public struct MCPerformMessageData {
    public let phone: String
    public let messageClientToken: MCFirebaseToken
    
    public init(phone: String, messageClientToken: MCFirebaseToken) {
        self.phone = phone
        self.messageClientToken = messageClientToken
    }
}
