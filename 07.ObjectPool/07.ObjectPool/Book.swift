//
//  Book.swift
//  07.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Book {
    let author: String
    let title: String
    let stockNumber: Int
    var reader: String?
    var checkoutCount: Int = 0
    
    init(_ author: String, _ title: String, _ stock: Int) {
        self.author = author; self.title = title; self.stockNumber = stock
    }
    
}
