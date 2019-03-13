//
//  MCUser.swift
//  MessagesClientGRPC
//
//  Created by Рабочий on 12/03/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

public class MCUser {
    public private(set) var id: String = String()
    public private(set) var name: String = String()
    public private(set) var phone: String?
    
    init(id: String, name: String, phone: String?) {
        self.id = id
        self.name = name
        self.phone = phone
    }
}
