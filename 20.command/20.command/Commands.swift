//
//  Commands.swift
//  20.command
//
//  Created by wdy on 2019/11/4.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol Command {
    func execute(receiver: Any)
}

class CommandWrapper: Command {
    
    private let commands: [Command]
    
    init(commands: [Command]) {
        self.commands = commands
    }
    
    func execute(receiver: Any) {
        self.commands.forEach { (command) in
            command.execute(receiver: receiver)
        }
    }
    
}

class GenericCommand<T>: Command {
    private var instructions: (T) -> Void
    
    init(instructions: @escaping (T) -> Void) {
        self.instructions = instructions
    }
    
    func execute(receiver: Any) {
        if let safeReceiver = receiver as? T {
            instructions(safeReceiver)
        } else {
            fatalError("Receiver is not expected type")
        }
    }
    
    class func createCommand(instructions: @escaping (T) -> Void) -> Command {
        return GenericCommand.init(instructions: instructions)
    }
    
}
