//
//  CarParts.swift
//  Composite
//
//  Created by wdy on 2019/10/29.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol CarPart {
    var name:String {get}
    var price: Float {get}
}

class Part: CarPart {
    let name: String
    let price: Float
    
    init(name: String, price: Float) {
        self.name = name
        self.price = price
    }
    
}

class CompositePart: CarPart {
    let name:String
    let parts: [CarPart]
    
    init(name: String, parts: Part...) {
        self.name = name
        self.parts = parts
    }
    
    var price: Float {
        return self.parts.reduce(0) { (subtotal, part) -> Float in
            return subtotal + part.price
        }
    }
    
}
