//
//  Utils.swift
//  SportsStore
//
//  Created by wdy on 2019/11/9.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Utils {
    
    class func currencyStringFromNumber(number: Double) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: number))!
    }
    
}
