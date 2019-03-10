//
//  LoadMessageOperation.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class LoadMessageOperation: Foundation.Operation {
    private var streamCall: Messageservice_MessageServicePerformMessageStreamCall?
    private let completion: (Messageservice_Message) -> Void
    private let userID: String
    private let login: String
    private let token: String
    private let messageStream: Messageservice_MessageServicePerformMessageStreamCall?
    private let messageClientGRPC: MessagesClientGRPC
    
    init(login: String,
         token: String,
         messageStream: Messageservice_MessageServicePerformMessageStreamCall?,
         userID: String,
         completion: @escaping (Messageservice_Message) -> Void,
         messageClientGRPC: MessagesClientGRPC) {
        self.completion = completion
        self.userID = userID
        self.login = login
        self.token = token
        self.messageStream = messageStream
        self.messageClientGRPC = messageClientGRPC
    }
    
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)
        
        var messageDisconnect = Messageservice_Message()
        messageDisconnect.id = "-1"
        messageDisconnect.text = "Couldn't connect"
        
        streamCall = messageStream
        
        messageDisconnect.text = "Disconnected"
        
        while true {
            if(isCancelled) {
                DispatchQueue.main.async {
                    self.completion(messageDisconnect)
                }
                semaphore.signal()
                break;
            }
            do {
                var message = try streamCall?.receive()
                if(message != nil) {
                    DispatchQueue.main.async {
                        if(message?.state == .sending && message?.receiver.id == self.userID) {
                            self.messageClientGRPC.verifyGet(message: MCMessage(GRPCMessage: message!), completion: { (result) in
                            })
                            message!.state = .delivered
                        }
                        self.completion(message!)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.completion(messageDisconnect)
                    }
                    semaphore.signal()
                    break;
                }
            } catch {
                DispatchQueue.main.async {
                    self.completion(messageDisconnect)
                }
                semaphore.signal()
                break;
            }
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
    override func cancel() {
        super.cancel()
        _ = try? streamCall?.closeSend()
        streamCall = nil
    }
}
