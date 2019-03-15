//
//  IMCNetworkService.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 15/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import SwiftGRPC

public protocol IMCNetworkService {
    func addConnectivityObserver(callback: @escaping (Channel.ConnectivityState) -> Void)
    func getCurrentConnectionState(callback: @escaping(Channel.ConnectivityState) -> Void)
}
