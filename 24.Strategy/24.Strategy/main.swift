//
//  main.swift
//  24.Strategy
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let sequence = Sequence.init(1, 2, 3, 4)
sequence.addNum(value: 10)
sequence.addNum(value: 20)

let sumStrategy = SumStrategy.init()
let multiplyStrategy = MultiplyStrategy.init()

let sum = sequence.compute(strategy: sumStrategy)
print("Sum : \(sum)")

let mul = sequence.compute(strategy: multiplyStrategy)
print("Multiply: \(mul)")

let filterThreshold = 10
let clusore = ClosureStrategy.init { (values) -> Int in
    return values.filter { (val) -> Bool in
        val < filterThreshold
    }.reduce(0) { (total, val) -> Int in
        return total + val
    }
}
let filtereSum = sequence.compute(strategy: clusore)
print("Filter Sum: \(filtereSum)")

