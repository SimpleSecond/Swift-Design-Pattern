//
//  main.swift
//  08.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

var queue = DispatchQueue.init(label: "workQ", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
var group = DispatchGroup.init()

print("Starting...")

for i in 1...35 {
    queue.async(group: group, execute: DispatchWorkItem.init(block: {
        let book = Library.checkoutBook(reader: "reader#\(i)")
        if book != nil {
            let rand = Int.random(in: 0...100)
            print(rand)
            Thread.sleep(forTimeInterval: Double(rand % 2))
            Library.returnBook(book: book!)
        } else {
            queue.sync(flags: .barrier) { () -> Void in
                print("Request \(i) failed")
            }
        }
    }))
}

print(group.wait(timeout: .distantFuture) == .success)

queue.sync(flags: .barrier) { () -> Void in
    print("All blocks complete")
    Library.printReport()
}
