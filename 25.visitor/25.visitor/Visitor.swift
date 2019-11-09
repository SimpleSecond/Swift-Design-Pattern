//
//  Visitor.swift
//  25.visitor
//
//  Created by wdy on 2019/11/7.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol Shape {
    func accept(visitor: Visitor)
}

protocol Visitor {
    func visit(shape: Circle)
    func visit(shape: Square)
    func visit(shape: Rectangle)
}

class AreaVisitor: Visitor {
    func visit(shape: Circle) {
        totalArea += (3.14 * powf(shape.radius, 2))
    }
    
    func visit(shape: Square) {
        totalArea += powf(shape.length, 2)
    }
    
    func visit(shape: Rectangle) {
        totalArea += (shape.xLen * shape.yLen)
    }
    
    var totalArea: Float = 0
}

class EdgesVisitor: Visitor {
    func visit(shape: Circle) {
        totalEdges += 1
    }
    
    func visit(shape: Square) {
        totalEdges += 4
    }
    
    func visit(shape: Rectangle) {
        totalEdges += 4
    }
    
    var totalEdges = 0
    
    
}
