//
//  Strategies.swift
//  24.Strategy
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol Strategy {
    func execute(values: [Int]) -> Int
}

class ClosureStrategy: Strategy {
    
    private let closure: ([Int]) -> Int
    
    init(_ closure: @escaping ([Int]) -> Int) {
        self.closure = closure
    }
    
    func execute(values: [Int]) -> Int {
        return self.closure(values)
    }
    
}

class SumStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(0) { (total, value) -> Int in
            return total + value
        }
    }
}

class MultiplyStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(1) { (total, val) -> Int in
            return total * val
        }
    }
}
