//
//  Flyweight.swift
//  17.Flyweight
//
//  Created by wdy on 2019/10/31.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol Flyweight {
    subscript(index: Coordinate) -> Int? { get set}
    
    var total: Int { get }
    var count: Int { get }
}

class FlyweightImpl: Flyweight {
    
    private let extrinsicData: [Coordinate: Cell]
    private var intrinsicData: [Coordinate: Cell]
    private let queue: DispatchQueue
    
    init(extrinsic: [Coordinate: Cell]) {
        self.extrinsicData = extrinsic
        self.intrinsicData = Dictionary<Coordinate, Cell>.init()
        self.queue = DispatchQueue.init(label: "dataQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    }
    
    subscript(index: Coordinate) -> Int? {
        get {
            var result: Int?
            self.queue.sync {
                if let cell = intrinsicData[index] {
                    result = cell.value
                } else {
                    result = extrinsicData[index]?.value
                }
            }
            return result
        }
        set (value) {
            if (value != nil) {
                self.queue.sync(flags: DispatchWorkItemFlags.barrier) { () -> Void in
                    intrinsicData[index] = Cell.init(col: index.col, row: index.row, val: value!)
                }
            }
        }
    }
    
    var total: Int {
        var result = 0
        
        self.queue.sync {
            result = extrinsicData.values.reduce(0) { (total, cell) -> Int in
                if let intrinsicCell = self.intrinsicData[cell.coordinate] {
                    return total + intrinsicCell.value
                } else {
                    return total + cell.value
                }
            }
        }
        
        return result
    }
    
    var count: Int {
        var result = 0
        self.queue.sync {
            result = self.intrinsicData.count
        }
        return result
    }
    
}


extension Dictionary {
    init(setupFunc:(() -> [(Key, Value)])) {
        self.init()
        for item in setupFunc() {
            self[item.0] = item.1
        }
    }
}

class FlyweightFactory {
    class func createFlyweight() -> Flyweight {
        return FlyweightImpl.init(extrinsic: extrinsicData)
    }
    
    private class var extrinsicData: [Coordinate: Cell] {
        get {
            struct singletonWrapper {
                static let singletonData = Dictionary<Coordinate, Cell>.init { () -> [(Coordinate, Cell)] in
                    var results = [(Coordinate, Cell)].init()
                    
                    let letters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    var stringIndex = letters.startIndex
                    let rows = 50
                    
                    repeat {
                        let colLetter = letters[stringIndex]
                        stringIndex = letters.index(after: stringIndex)
                        for rowIndex in 1...rows {
                            let cell = Cell.init(col: colLetter, row: rowIndex, val: rowIndex)
                            results.append((cell.coordinate, cell))
                        }
                    } while stringIndex != letters.endIndex
                    return results
                }
            }
            return singletonWrapper.singletonData
        }
    }
    
}
