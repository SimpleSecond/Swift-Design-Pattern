//
//  Sequence.swift
//  24.Strategy
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


final class Sequence {
    
    private var numbers: [Int]
    
    init(_ numbers: Int...) {
        self.numbers = numbers
    }
    
    func addNum(value: Int) {
        self.numbers.append(value)
    }
    
    func compute(strategy: Strategy) -> Int {
        return strategy.execute(values: self.numbers)
    }
}
