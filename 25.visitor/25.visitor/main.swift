//
//  main.swift
//  25.visitor
//
//  Created by wdy on 2019/11/7.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let shapes = ShapeCollection.init()
let areaVisitor = AreaVisitor.init()

shapes.accept(visitor: areaVisitor)

print("Area: \(areaVisitor.totalArea)")

print("------")

let edgeVisitor = EdgesVisitor.init()
shapes.accept(visitor: edgeVisitor)
print("Edges: \(edgeVisitor.totalEdges)")
