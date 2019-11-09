//
//  main.swift
//  ChainOfResp
//
//  Created by wdy on 2019/10/31.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let messages = [
    Message(from: "bob@example.com", to: "joe@example.com", subject: "Free for lunch?"),
    Message(from: "joe@example.com", to: "alice@acme.com", subject: "New Contracts"),
    Message(from: "pete@example.com", to: "all@example.com", subject: "Priority: All-Hands Meeting"),
//    Message(from: "pete@example.com", to: "all@example.com", subject: "All-Hands Meeting"),
//    Message(from: "pete@example.com", to: "all@example.com", subject: "All-Hands Meeting"),
//    Message(from: "pete@example.com", to: "all@example.com", subject: "Priority: All-Hands Meeting")
]

if let chain = Transmitter.createChain(localOnly: true) {
    for msg in messages {
        let handled = chain.sendMessage(message: msg)
        print("Message sent: \(handled)")
    }
}
