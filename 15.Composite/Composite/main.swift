//
//  main.swift
//  Composite
//
//  Created by wdy on 2019/10/29.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let doorWindow = CompositePart.init(name: "DoorWindow", parts:
    Part.init(name: "Window", price: 100.50), Part.init(name: "Window Switch", price: 12))

let door = CompositePart.init(name: "Door", parts: Part.init(name: "Window", price: 100.50), Part.init(name: "Door Loom", price: 80), Part.init(name: "Window Switch", price: 12), Part.init(name: "Door Handles", price: 43.40))

let hood = Part.init(name: "Hood", price: 320)

let order = CustomOrder.init(customer: "Bob", parts: [hood, door, doorWindow])

order.printDetails()

