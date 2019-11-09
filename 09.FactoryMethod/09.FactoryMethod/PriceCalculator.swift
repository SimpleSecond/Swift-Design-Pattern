//
//  PriceCalculator.swift
//  09.FactoryMethod
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class PriceCalculator {
    
    class func calculatePrice(passengers: Int, days: Int) -> Float? {
        let car = RentalCar.createRentalCar(passengers: passengers)
        return car == nil ? nil : car!.pricePerDay * Float(days)
    }
    
}
