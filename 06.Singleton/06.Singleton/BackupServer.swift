//
//  BackupServer.swift
//  06.Singleton
//
//  Created by wdy on 2019/11/7.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class DataItem {
    
    enum ItemType: String {
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card  = "Credit Card Number"
    }
    
    var type: ItemType
    var data: String
    
    init(type: ItemType, data: String) {
        self.type = type; self.data = data
    }
}

final class BackupServer {
    let name: String
    private var data = [DataItem].init()
    private let arrayQ = DispatchQueue.init(label: "arrayQ")
    
    private init(name: String) {
        self.name = name
        Logger.instance.log(msg: "Created new server \(name)")
    }
    
    func backup(item: DataItem) {
        self.arrayQ.sync {
            self.data.append(item)
            Logger.instance.log(msg: "\(self.name) backed up item of type \(item.type.rawValue)")
        }
    }
    
    func getData() -> [DataItem] {
        return self.data
    }
    
    class var server: BackupServer {
        struct SingletonWrapper {
            static let singleton = BackupServer.init(name: "MainServer")
        }
        return SingletonWrapper.singleton
    }
    
}
