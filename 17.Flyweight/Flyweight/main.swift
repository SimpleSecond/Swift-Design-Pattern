//
//  main.swift
//  Flyweight
//
//  Created by wdy on 2019/10/31.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let ss1 = Spreadsheet.init()
ss1.setValue(coord: Coordinate.init(col: "A", row: 1), value: 100)
ss1.setValue(coord: Coordinate.init(col: "J", row: 20), value: 200)
print("SS1 Total: \(ss1.total)")


let ss2 = Spreadsheet.init()
ss2.setValue(coord: Coordinate.init(col: "F", row: 10), value: 200)
ss2.setValue(coord: Coordinate.init(col: "G", row: 23), value: 250)
print("SS1 Total: \(ss2.total)")


print("Cells created: \(1300 + ss1.grid.count + ss2.grid.count)")
