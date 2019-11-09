//
//  Orders.swift
//  Composite
//
//  Created by wdy on 2019/10/29.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class CustomOrder {
    let customer: String
    let parts: [CarPart]
    
    
    init(customer: String, parts:[CarPart]) {
        self.customer = customer
        self.parts = parts
    }
    
    var totalPrice: Float {
        return self.parts.reduce(0) { (subtotal, part) -> Float in
            return subtotal + part.price
        }
    }
    
    func printDetails() -> Void {
        print("Order for \(customer): Cost: \(formatCurrencyString(number: totalPrice))")
    }
    
    func formatCurrencyString(number: Float) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
}
