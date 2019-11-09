//
//  main.swift
//  06.Singleton
//
//  Created by wdy on 2019/11/7.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


let server = BackupServer.server

let queue = DispatchQueue.init(label: "workQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)

let group = DispatchGroup.init()

for count in 0..<100 {
    queue.async(group: group, execute: DispatchWorkItem.init(block: {
        BackupServer.server.backup(item: DataItem.init(type: .Email, data: "bob@example.com"))
    }))
}

group.wait(timeout: DispatchTime.distantFuture)

print("\(server.getData().count) items were backed up")

Logger.instance.printLog()
