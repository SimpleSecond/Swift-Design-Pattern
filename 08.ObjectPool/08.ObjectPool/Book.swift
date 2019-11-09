//
//  Book.swift
//  08.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Book: PoolItem {
    let author: String
    let title: String
    let stockNumber: Int
    var reader: String?
    var checkoutCount: Int = 0
    
    init(author: String, title: String, stock: Int) {
        self.author = author; self.title = title; self.stockNumber = stock
    }
    
    var canReuse: Bool {
        get {
            return false
        }
    }
    
}
