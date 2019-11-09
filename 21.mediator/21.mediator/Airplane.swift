//
//  Airplane.swift
//  21.mediator
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

struct Position {
    var distanceFromRunway: Int
    var height: Int
}

class Airplane: MessagePeer {
    var name: String
    var currentPosition: Position
    var mediator: MessageMediator
    let queue = DispatchQueue.init(label: "posQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    init(name: String, initialPos: Position, mediator: MessageMediator) {
        self.name = name
        self.currentPosition = initialPos
        self.mediator = mediator
        mediator.registerPeer(peer: self)
    }
    
    
    
    func handleMessage(messageType: String, data: Any?) -> Any? {
        var result: Any?
        
        switch messageType {
        case "changePos":
            if let pos = data as? Position {
                result = otherPlaneDidChangePosition(position: pos)
            }
        default:
            fatalError("Unknown message type")
        }
        return result
    }
    
    
    func otherPlaneDidChangePosition(position: Position) -> Bool {
        var result = false
        self.queue.sync {
            result = position.distanceFromRunway == self.currentPosition.distanceFromRunway
                && abs(position.height - self.currentPosition.height) < 1000
        }
        return result
    }
    
    func changePosition(newPos: Position) {
        self.queue.sync(flags: .barrier) { () -> Void in
            self.currentPosition = newPos
            
            let allResults = self.mediator.sendMessage(celler: self, messageType: "changePos", data: newPos)
            
            for result in allResults {
                if result as? Bool == true {
                    print("\(self.name): Too close! Abort!")
                    return
                }
            }
            print("\(self.name): Position changed")
        }
    }
    
    func land() {
        self.queue.sync(flags: .barrier) { () -> Void in
            self.currentPosition = Position(distanceFromRunway: 0, height: 0)
            self.mediator.unregisterPeer(peer: self)
            print("\(self.name) : Landed")
        }
    }
}
