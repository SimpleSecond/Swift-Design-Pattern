//
//  Ledger.swift
//  23.memento
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class LedgerEntry {
    let id: Int
    let counterParty: String
    let amount : Float
    
    init(id: Int, counterParty: String, amount: Float) {
        self.id = id; self.counterParty = counterParty; self.amount = amount
    }
}

class LedgerMemento: Memento {
    let data: Data
    init(data: Data) {
        self.data = data
    }
}

class Ledger: NSObject, NSCoding, Originator {
    
    private var entries = [Int: LedgerEntry].init()
    private var nextId = 1
    var total: Float = 0
    
    override init() {
        //
    }
    
    required init?(coder: NSCoder) {
        self.total = coder.decodeFloat(forKey: "total")
        self.nextId = coder.decodeInteger(forKey: "nextId")
        self.entries.removeAll(keepingCapacity: true)
        if let entryArray = coder.decodeObject() as AnyObject? as? [Dictionary<String, Any>] {
            for entryDict in entryArray {
                let id = entryDict["id"] as! Int
                let counterParty = entryDict["counterParty"] as! String
                let amount = entryDict["amount"] as! Float
                self.entries[id] = LedgerEntry.init(id: id, counterParty: counterParty, amount: amount)
            }
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(total, forKey: "total")
        coder.encode(nextId, forKey: "nextId")
        var entriesArray = [Dictionary<String, Any>].init()
        for entry in self.entries.values {
            var dict = Dictionary<String, Any>.init()
            dict["id"] = entry.id
            dict["counterParty"] = entry.counterParty
            dict["amount"] = entry.amount
            entriesArray.append(dict)
        }
        coder.encode(entriesArray)
    }
    
    func createMemento() -> Memento {
        let data = try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        return LedgerMemento.init(data: data)
    }
    
    func applyMemento(memento: Memento) {
        if let lmemento = memento as? LedgerMemento {
            let obj = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Ledger.self, from: lmemento.data)!
            self.total = obj.total
            self.nextId = obj.nextId
            self.entries = obj.entries
        }
    }
    
    func addEntry(counterParty: String, amount: Float) {
        let entry = LedgerEntry.init(id: nextId+1, counterParty: counterParty, amount: amount)
        entries[entry.id] = entry
        total += amount
    }
    
    func printEntries() {
        for id in entries.keys.sorted() {
            let entry = entries[id]
            print("#\(id): \(entry?.counterParty) $\(entry?.amount)")
        }
        print("Total: $\(total)")
        print("------")
    }
    
}

