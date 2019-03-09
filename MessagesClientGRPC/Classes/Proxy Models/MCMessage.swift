//
//  MCMessage.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public enum MCMessageState {
    case queued // = 0
    case sending // = 1
    case delivered // = 2
    case failed // = 3
    case unrecognized
}

public class MCMessage {
    public private(set) var id: String = String()
    public private(set) var text: String = String()
    public private(set) var receiverID: String = String()
    public private(set) var token: String = String()
    public private(set) var date: String = String()
    public private(set) var state: MCMessageState = .queued
    public private(set) var senderID: String = String()
    
    var message: Messageservice_Message {
        var message = Messageservice_Message()
        message.id = id
        message.text = text
        message.receiverID = receiverID
        message.token = token
        message.date = date
        switch state {
        case .queued:
            message.state = .queued
        case .sending:
            message.state = .sending
        case .delivered:
            message.state = .delivered
        case .failed:
            message.state = .failed
        default:
            message.state = .UNRECOGNIZED(0)
        }
        message.senderID = senderID
        
        return message
    }
    
    public init(text: String, receiverID: String) {
        self.text = text
        self.receiverID = receiverID
    }
    
    init(id: String, text: String, receiverID: String, token: String, date: String, state: MCMessageState, senderID: String) {
        self.id = id
        self.text = text
        self.receiverID = receiverID
        self.token = token
        self.date = date
        self.state = state
        self.senderID = senderID
    }
    
    init(GRPCMessage: Messageservice_Message) {
        self.id = GRPCMessage.id
        self.text = GRPCMessage.text
        self.receiverID = GRPCMessage.receiverID
        self.token = GRPCMessage.token
        self.date = GRPCMessage.date
        switch GRPCMessage.state {
        case .queued:
            self.state = .queued
        case .sending:
            self.state = .sending
        case .delivered:
            self.state = .delivered
        case .failed:
            self.state = .failed
        default:
            self.state = .unrecognized
        }
        self.senderID = GRPCMessage.senderID
    }
    
    func setState(state: MCMessageState) {
        self.state = state
    }
}
