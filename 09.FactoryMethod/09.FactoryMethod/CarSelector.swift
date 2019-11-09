//
//  CarSelector.swift
//  09.FactoryMethod
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class CarSelector {
    class func selectCar(passengers: Int) -> String? {
        return RentalCar.createRentalCar(passengers: passengers)?.name
    }
}
