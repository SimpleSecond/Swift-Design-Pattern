//
//  Pool.swift
//  07.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Pool<T> {
    
    private var data: [T] = [T].init()
    private let arrayQ: DispatchQueue = DispatchQueue.init(label: "arrayQ")
    private let semaphore: DispatchSemaphore
    
    init(items:[T]) {
        data.reserveCapacity(data.count)
        for item in items {
            data.append(item)
        }
        semaphore = DispatchSemaphore.init(value: items.count)
    }
    
    func getFromPool() -> T? {
        var result: T?
        if self.semaphore.wait(timeout: DispatchTime.distantFuture) == .success {
            self.arrayQ.sync {
                result = self.data.remove(at: 0)
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
    
}
