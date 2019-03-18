//
//  MCMessage.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public struct MCSender {
    public var id: String
    public var nickName: String
}

public struct MCReceiver {
    public var id: String
    
    public init(id: String) {
        self.id = id
    }
}

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
    public private(set) var receiver: MCReceiver = MCReceiver(id: "")
    public private(set) var token: String = String()
    public private(set) var date: Int = Int()
    public private(set) var state: MCMessageState = .queued
    public private(set) var sender: MCSender = MCSender(id: "", nickName: "")
    public private(set) var code: Int = Int()
    
    var message: Messageservice_Message {
        var message = Messageservice_Message()
        message.id = id
        message.text = text
        message.receiver = Messageservice_Receiver()
        message.receiver.id = receiver.id
        message.token = token
        message.date = Int32(date)
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
        message.sender = Messageservice_Sender()
        message.sender.id = sender.id
        message.sender.nickName = sender.nickName
        
        return message
    }
    
    public init(text: String, receiver: MCReceiver) {
        self.text = text
        self.receiver = receiver
    }
    
    init(id: String, text: String, receiver: MCReceiver, token: String, date: Int, state: MCMessageState, sender: MCSender) {
        self.id = id
        self.text = text
        self.receiver = receiver
        self.token = token
        self.date = date
        self.state = state
        self.sender = sender
    }
    
    init(GRPCMessage: Messageservice_Message) {
        self.id = GRPCMessage.id
        self.text = GRPCMessage.text
        self.receiver.id = GRPCMessage.receiver.id
        self.token = GRPCMessage.token
        self.date = Int(GRPCMessage.date)
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
        self.sender.id = GRPCMessage.sender.id
        self.sender.nickName = GRPCMessage.sender.nickName
    }
    
    func setState(state: MCMessageState) {
        self.state = state
    }
}
