//
//  IMessageService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 13/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public protocol IMCMessageService: IMCNetworkService {
    func send(message: MCMessage, completion: @escaping (CallResult?) -> Void)
    func performMessageStream(data: MCPerformMessageData, completion: @escaping (MCMessage) -> Void)
}
