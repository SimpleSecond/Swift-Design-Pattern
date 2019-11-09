//
//  Spreadsheet.swift
//  17.Flyweight
//
//  Created by wdy on 2019/10/31.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class Coordinate: Hashable {
    
    let col: Character
    let row: Int
    
    init(col: Character, row: Int) {
        self.col = col; self.row = row
    }
    
    var hashValue: Int {
        return description.hashValue
    }
    
    var description: String {
        return "\(col)\(row)"
    }
    
    
    func hash(into hasher: inout Hasher) {
        //print("hash into")
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.col == rhs.col && lhs.row == rhs.row
    }
}

class Cell {
    var coordinate: Coordinate
    var value: Int
    
    init(col: Character, row: Int, val: Int) {
        self.coordinate = Coordinate.init(col: col, row: row)
        self.value = val
    }
}

class Spreadsheet {
    var grid: Flyweight
    
    init() {
        grid = FlyweightFactory.createFlyweight()
    }
    
    func setValue(coord: Coordinate, value: Int) -> Void {
        grid[coord] = value
    }
    
    var total: Int {
        return grid.total
    }
    
    
}

