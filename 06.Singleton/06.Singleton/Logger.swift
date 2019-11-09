//
//  Logger.swift
//  06.Singleton
//
//  Created by wdy on 2019/11/7.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


final class Logger {
    
    private var data = [String].init()
    private let arrayQ = DispatchQueue.init(label: "loggerQ")
    
    private init() {}
    class var instance: Logger {
        struct SingletonWrapper {
            static let singleton = Logger.init()
        }
        return SingletonWrapper.singleton
    }
    
    func log(msg: String) {
        self.arrayQ.sync {
            self.data.append(msg)
        }
    }
    
    func printLog() {
        for msg in self.data {
            print("Log: \(msg)")
        }
    }
}
