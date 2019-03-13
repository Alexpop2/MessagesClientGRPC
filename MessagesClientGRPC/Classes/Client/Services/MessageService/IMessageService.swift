//
//  IMessageService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public protocol IMessageService {
    func send(message: MCMessage, completion: @escaping (CallResult?) -> Void)
    func performMessageStream(data: MCPerformMessageData, completion: @escaping (MCMessage) -> Void)
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void)
}
