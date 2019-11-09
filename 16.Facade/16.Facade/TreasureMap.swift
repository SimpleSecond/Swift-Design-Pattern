//
//  TreasureMap.swift
//  16.Facade
//
//  Created by wdy on 2019/10/30.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class TreasureMap {
    
    enum Treasures {
        case GALLEON; case BURIED_GOLD; case SUNKEN_JEWELS;
    }
    
    struct MapLocation {
        let gridLetter: Character
        let gridNumber: UInt
    }
    
    func findTreasure(type: Treasures) -> MapLocation {
        switch type {
        case .GALLEON:
            return MapLocation(gridLetter: "D", gridNumber: 6)
        case .BURIED_GOLD:
            return MapLocation(gridLetter: "C", gridNumber: 2)
        case .SUNKEN_JEWELS:
            return MapLocation(gridLetter: "F", gridNumber: 12)
        }
    }
    
}
