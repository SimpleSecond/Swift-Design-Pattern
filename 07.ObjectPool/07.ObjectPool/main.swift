//
//  main.swift
//  07.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


var queue = DispatchQueue.init(label: "workQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
var group = DispatchGroup.init()

print("Starting...")


for i in 1...20 {
    queue.async(group: group, execute: DispatchWorkItem.init(block: {
        let book = Library.checkoutBook(reader: "reader#\(i)")
        if book != nil {
            let rand = Int.random(in: 0...100)
            Thread.sleep(forTimeInterval: Double(rand % 2))
            Library.returnBook(book: book!)
        }
    }))
}

group.wait(timeout: DispatchTime.distantFuture)

print("All blocks complete")

Library.printReport()
