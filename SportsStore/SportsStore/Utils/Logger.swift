//
//  Logger.swift
//  SportsStore
//
//  Created by wdy on 2019/11/9.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class Logger<T> where T:NSObject, T:NSCopying {
    
    var dataItems:[T] = []
    var callback:(T) -> Void
    var arrayQ: DispatchQueue = DispatchQueue.init(label: "arrayQ", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    var callbackQ: DispatchQueue = DispatchQueue.init(label: "callbackQ")
    
    fileprivate init(callback: @escaping (T) -> Void, protect: Bool = true) {
        self.callback = callback
        if protect {
            self.callback = {(item: T) in
                self.callbackQ.sync {
                    callback(item)
                }
            }
        }
    }
    
    func logItem(item: T) {
        self.arrayQ.sync(flags: .barrier) { () -> Void in
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
    }
    
    func processItems(callback: (T) -> Void) {
        self.arrayQ.sync {
            for item in self.dataItems {
                callback(item)
            }
        }
    }
    
}

let productLogger = Logger<Product>.init(callback: { (product) in
    print("Change: \(product.name) \(product.stockLevel) items in stock")
})


