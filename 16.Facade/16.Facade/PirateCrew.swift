//
//  PirateCrew.swift
//  16.Facade
//
//  Created by wdy on 2019/10/30.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class PirateCrew {
    
    let workQueue = DispatchQueue.init(label: "crewWorkQ")
    
    enum Actions {
        case ATTACK_SHIP; case DIG_FOR_GOLD; case DIVE_FOR_JEWELS;
    }
    
    func performAction(action: Actions, callback: @escaping (Int) -> Void) -> Void {
        
        workQueue.async {
            var prizeValue = 0
            switch action {
            case .ATTACK_SHIP:
                prizeValue = 10000
            case .DIG_FOR_GOLD:
                prizeValue = 5000
            case .DIVE_FOR_JEWELS:
                prizeValue = 1000
            }
            callback(prizeValue)
        }
        
    }
    
}
