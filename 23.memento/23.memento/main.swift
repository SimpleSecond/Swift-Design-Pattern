//
//  main.swift
//  23.memento
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let ledger = Ledger.init()

ledger.addEntry(counterParty: "Bob", amount: 100.43)
ledger.addEntry(counterParty: "Joe", amount: 200.20)

let memento = ledger.createMemento()

ledger.applyMemento(memento: memento)


ledger.printEntries()

