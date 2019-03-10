//
//  TryConnectionOperation.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 08/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class TryConnectionOperation: Foundation.Operation {
    private let completion: (Messageservice_Message) -> Void
    private let messageClient: Messageservice_MessageServiceServiceClient?
    private let setConnectionStateTrue: () -> Void
    
    init(messageClient: Messageservice_MessageServiceServiceClient?,
         completion: @escaping (Messageservice_Message) -> Void, setConnectionStateTrue: @escaping () -> Void) {
        self.completion = completion
        self.messageClient = messageClient
        self.setConnectionStateTrue = setConnectionStateTrue
    }
    
    
    override func main() {
        
        var messageDisconnect = Messageservice_Message()
        messageDisconnect.id = "-1"
        messageDisconnect.text = "Trying to connect"
        
        DispatchQueue.main.async {
            self.completion(messageDisconnect)
        }
        var i = 10
        while i > 0 {
            if(isCancelled) {
                return
            }
            if(self.messageClient?.channel.connectivityState(tryToConnect: true) == .ready) {
                if(!isCancelled) {
                    self.setConnectionStateTrue()
                    return
                }
            }
            if(isCancelled) {
                return
            }
            usleep(300000)
            i -= 1
        }
        if(isCancelled) {
            return
        }
        messageDisconnect.text = "Couldn't connect"
        
        DispatchQueue.main.async {
            self.completion(messageDisconnect)
        }
        
    }
    
    override func cancel() {
        super.cancel()
    }
}
