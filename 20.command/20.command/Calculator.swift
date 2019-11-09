//
//  Calculator.swift
//  20.command
//
//  Created by wdy on 2019/11/4.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class Calculator {
    
    private(set) var total = 0
    typealias CommandClosure = ((Calculator) -> Void)
    private var history = [CommandClosure].init()
    private let queue = DispatchQueue.init(label: "arrayQ")
    
    func add(amount: Int) {
        addMacro(method: Calculator.add, amount: amount)
        total += amount
    }
    
    func subtract(amount: Int) {
        addMacro(method: Calculator.subtract, amount: amount)
        total -= amount
    }
    
    func multiply(amount: Int) -> Void {
        addMacro(method: Calculator.multiply, amount: amount)
        total = total * amount
    }
    
    func divide(amount: Int) -> Void {
        addMacro(method: Calculator.divide, amount: amount)
        total = total / amount
    }
    
    private func addMacro(method: @escaping (Calculator) -> (Int) -> Void, amount: Int) {
        self.queue.sync {
            self.history.append { (calc) in
                method(calc)(amount)
            }
        }
    }
    
    func getMacroCommand() -> ((Calculator) -> Void) {
        var commands = [CommandClosure].init()
        self.queue.sync {
            commands = self.history
        }
        
        return { calc in
            if commands.count > 0 {
                for index in 0..<commands.count {
                    commands[index](calc)
                }
            }
        }
        
    }
    
}
