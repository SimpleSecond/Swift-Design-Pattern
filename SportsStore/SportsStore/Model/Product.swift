//
//  Product.swift
//  SportsStore
//
//  Created by wdy on 2019/11/9.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying {

    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    private var stockLevelBackingValue: Int = 0
    private var priceBackingValue: Double = 0

    
    init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        self.name = name; self.productDescription = description; self.category = category;
        super.init()
        self.price = price
        self.stockLevel = stockLevel
    }
    
    var stockLevel: Int {
        set{ stockLevelBackingValue = max(0, newValue) }
        get{ return stockLevelBackingValue }
    }
    private(set) var price: Double {
        set{ priceBackingValue = max(1, newValue) }
        get{ return priceBackingValue }
    }
    
    var stockValue: Double {
        get{ return price * Double(stockLevel) }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product.init(name: self.name, description: self.description, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }

}
