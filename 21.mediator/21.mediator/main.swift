//
//  main.swift
//  21.mediator
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let mediator = MessageMediator.init()

//
let british = Airplane.init(name: "BA706", initialPos: Position(distanceFromRunway: 11, height: 21000), mediator: mediator)

// new plane
let american = Airplane.init(name: "AA101", initialPos: Position(distanceFromRunway: 12, height: 22000), mediator: mediator)

// plane approachs airport
british.changePosition(newPos: Position(distanceFromRunway: 8, height: 10000))
british.changePosition(newPos: Position(distanceFromRunway: 2, height: 5000))
british.changePosition(newPos: Position(distanceFromRunway: 1, height: 1000))

// new plane
let cathay = Airplane.init(name: "CX200", initialPos: Position(distanceFromRunway: 13, height: 22000), mediator: mediator)

british.land()


cathay.changePosition(newPos: Position(distanceFromRunway: 12, height: 22000))
