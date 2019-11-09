//
//  main.swift
//  16.Facade
//
//  Created by wdy on 2019/10/30.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


let facade = PirateFacade.init()
let prize = facade.getTreature(type: .SHIP)

if prize != 0 {
    print("Prize: \(prize) pieces of eight")
}


FileHandle.standardInput.availableData
