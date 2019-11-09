//
//  main.swift
//  09.FactoryMethod
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let passengers: [Int] = [1, 3, 5]

for p in passengers {
    print("\(p) passengers: \(CarSelector.selectCar(passengers: p)!)")
}

