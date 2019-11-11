//
//  NetworkPool.swift
//  SportsStore
//
//  Created by wdy on 2019/11/11.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

final class NetworkPool {
    
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore: DispatchSemaphore
    private var queue: DispatchQueue
    
    private init() {
        for _ in 0..<connectionCount {
            connections.append(NetworkConnection.init())
        }
        semaphore = DispatchSemaphore.init(value: connectionCount)
        queue = DispatchQueue.init(label: "networkpoolQ")
    }
    
    private func doGetConnection() -> NetworkConnection {
        self.semaphore.wait(timeout: .distantFuture)
        var result: NetworkConnection? = nil
        self.queue.sync {
            result = self.connections.remove(at: 0)
        }
        return result!
    }
    
    private func doReturnConnection(conn: NetworkConnection) {
        self.queue.async {
            self.connections.append(conn)
            self.semaphore.signal()
        }
    }
    
    class func getConnection() -> NetworkConnection {
        return instance.doGetConnection()
    }
    
    class func returnConnection(conn: NetworkConnection) {
        instance.doReturnConnection(conn: conn)
    }
    
    private class var instance: NetworkPool {
        get {
            struct SingletonWrapper {
                static let singleton = NetworkPool.init()
            }
            return SingletonWrapper.singleton
        }
    }
    
}
