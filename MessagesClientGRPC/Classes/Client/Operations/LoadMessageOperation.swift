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
    private let login: String
    private let token: String
    private let messageStream: Messageservice_MessageServicePerformMessageStreamCall?
    private let messageService: MCMessageService
    
    init(login: String,
         token: String,
         messageStream: Messageservice_MessageServicePerformMessageStreamCall?,
         completion: @escaping (Messageservice_Message) -> Void,
         messageService: MCMessageService) {
        self.completion = completion
        self.login = login
        self.token = token
        self.messageStream = messageStream
        self.messageService = messageService
    }
    
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)
        
        var messageDisconnect = Messageservice_Message()
        messageDisconnect.id = "-1"
        messageDisconnect.text = "Couldn't connect"
        messageDisconnect.code = 201
        
        streamCall = messageStream
        
        messageDisconnect.text = "Disconnected"
        messageDisconnect.code = 202
        
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
                        if(message?.state == .sending && message?.phone == self.login) {
                            self.messageService.verifyGet(message: MCMessage(GRPCMessage: message!), completion: { (result) in
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
