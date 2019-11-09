//
//  Memento.swift
//  23.memento
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol Memento {
    //
}

protocol Originator {
    func createMemento() -> Memento
    func applyMemento(memento: Memento)
}
