//
//  NetworkRequest.swift
//  Adapter
//
//  Created by wdy on 2019/9/9.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


protocol NetworkConnection {
    func connect()
    func disconnect()
    func sendCommand(command: String)
}

class NetworkConnectionFactory {
    
    class func createNetwork() -> NetworkConnection {
        return connectionProxy
    }
    
    private class var connectionProxy: NetworkConnection {
        get {
            struct singletonWrapper {
                static let singleton = NetworkRequestProxy.init()
            }
            return singletonWrapper.singleton
        }
    }
}

class NetworkRequestProxy: NetworkConnection {
    
    
    private let wrappedRequest: NetworkConnection
    private let queue = DispatchQueue.init(label: "commandQ")
    private var referenceCount: Int = 0
    private var connected = false
    
    
    init() {
        wrappedRequest = NetworkConnectionImpl.init()
    }
    
    
    func connect() {
        // nothing
    }
    
    func disconnect() {
        // nothing
    }
    
    func sendCommand(command: String) {
        self.referenceCount += self.referenceCount
        self.queue.sync {
            if !self.connected && self.referenceCount > 0 {
                self.wrappedRequest.connect()
                self.connected = true
            }
            self.wrappedRequest.sendCommand(command: command)
            self.referenceCount -= self.referenceCount
            if self.connected && self.referenceCount == 0 {
                self.wrappedRequest.disconnect()
                self.connected = false
            }
        }
    }
}


// 第一个实现
private class NetworkConnectionImpl: NetworkConnection {
    
    typealias me = NetworkConnectionImpl
    
    func connect() {
        me.writeMessage(msg: "Connect")
    }
    
    func disconnect() {
        me.writeMessage(msg: "Disconnect")
    }
    
    func sendCommand(command: String) {
        me.writeMessage(msg: "Command: \(command)")
        Thread.sleep(forTimeInterval: 1)
        me.writeMessage(msg: "Command completed: \(command)")
    }
    
    
    private class func writeMessage(msg: String) -> Void {
        self.queue.async {
            print("\(msg) \n")
        }
    }
    
    private class var queue: DispatchQueue {
        get {
            struct singletonWrapper {
                static let singleton = DispatchQueue.init(label: "writeQ")
            }
            return singletonWrapper.singleton
        }
    }
    
    
}
