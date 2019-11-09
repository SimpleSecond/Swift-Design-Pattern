//
//  Facade.swift
//  16.Facade
//
//  Created by wdy on 2019/10/30.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

enum TreasureTypes {
    case SHIP; case BURIED; case SUNKEN;
}

class PirateFacade {
    
    let map = TreasureMap.init()
    let ship = PirateShip.init()
    let crew = PirateCrew.init()
    
    let semaphore = DispatchSemaphore.init(value: 0)
    
    func getTreature(type: TreasureTypes) -> Int {
        var prizeAmount: Int?
        
        var treasureType: TreasureMap.Treasures
        var crewWorkType: PirateCrew.Actions
        
        switch type {
        case .SHIP:
            treasureType = .GALLEON
            crewWorkType = .ATTACK_SHIP
        case .BURIED:
            treasureType = .BURIED_GOLD
            crewWorkType = .DIG_FOR_GOLD
        case .SUNKEN:
            treasureType = .SUNKEN_JEWELS
            crewWorkType = .DIVE_FOR_JEWELS
        }
        
        let treasureLocation = map.findTreasure(type: treasureType)
        
        let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
        let eastWestPos = sequence.firstIndex(of: treasureLocation.gridLetter)
        let shipTarget = PirateShip.ShipLocation.init(NorthSouth: Int(treasureLocation.gridNumber), EastWet: eastWestPos!)
        
        
        ship.moveToLocation(location: shipTarget) { (location) in
            self.crew.performAction(action: .ATTACK_SHIP) { (prize) in
//                print("Prize: \(prize) pieces of eight")
                prizeAmount = prize
                self.semaphore.signal()
            }
        }
        
        self.semaphore.wait()
        
        return prizeAmount!
    }
    
    
    
}
