//
//  Pool.swift
//  08.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Pool<T: AnyObject> {
    private var data = [T].init()
    private let arrayQ: DispatchQueue = DispatchQueue.init(label: "arrayQ")
    private let semaphore: DispatchSemaphore

    // Block
    private let itemFactory: () -> T
    private let itemAllocator: ([T]) -> Int
    //
    private let maxItemCount: Int
    private var createdCount: Int = 0

    init(itemCount: Int, itemFactory: @escaping ()->T, itemAllocator: @escaping ([T]) -> Int) {
        self.maxItemCount = itemCount
        self.itemFactory = itemFactory
        self.itemAllocator = itemAllocator
        self.semaphore = DispatchSemaphore.init(value: itemCount)
    }

    func getFromPool() -> T? {
        var result: T?
        if self.semaphore.wait(timeout: .distantFuture) == .success {
            self.arrayQ.sync {
                if self.data.count == 0 {
                    result = self.itemFactory()
                    self.createdCount += 1
                } else {
                    result = self.data.remove(at: self.itemAllocator(self.data))
                }
            }
        }
        return result
    }
    
    func returnToPool(item: T) {
        self.arrayQ.async {
            self.data.append(item)
            self.semaphore.signal()
        }
    }
    
    func processPoolItems(callback: ([T]) -> Void) {
        self.arrayQ.sync {
            callback(self.data)
        }
    }
    
}


