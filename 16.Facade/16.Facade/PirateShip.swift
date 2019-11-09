
//
//  PirateShip.swift
//  16.Facade
//
//  Created by wdy on 2019/10/30.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class PirateShip {
    struct ShipLocation {
        let NorthSouth: Int
        let EastWet: Int
    }
    
    var currentPosition: ShipLocation
    var movementQueue = DispatchQueue.init(label: "shipQ")
    
    init() {
        currentPosition = ShipLocation(NorthSouth: 5, EastWet: 5)
    }
    
    func moveToLocation(location: ShipLocation, callback:@escaping (ShipLocation) -> Void) {
        movementQueue.async {
            self.currentPosition = location
            callback(self.currentPosition)
        }
    }
    
}
