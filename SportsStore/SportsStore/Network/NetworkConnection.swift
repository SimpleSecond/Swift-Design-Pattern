//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by wdy on 2019/11/11.
//  Copyright © 2019 wdy. All rights reserved.
//
import Foundation

class NetworkConnection {
    
    private let stockData: [String: Int] = [
        "Kayak": 10, "Lifejacket": 14, "Soccer Ball": 32, "Corner Flags": 1,
        "Stadium": 4, "Thinking Cap": 8, "Unsteady Chair": 3,
        "Human Chess Board": 2, "Bling-Bling King": 4
    ]
    
    func getStockLevel(name: String) -> Int? {
        Thread.sleep(forTimeInterval: 10.0)
        return stockData[name]
    }
    
}
