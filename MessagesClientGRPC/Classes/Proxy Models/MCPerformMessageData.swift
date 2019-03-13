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
    public let userID: String
    public let userNickName: String
    
    public init(phone: String, messageClientToken: MCFirebaseToken, userID: String, userNickName: String) {
        self.phone = phone
        self.messageClientToken = messageClientToken
        self.userID = userID
        self.userNickName = userNickName
    }
}
