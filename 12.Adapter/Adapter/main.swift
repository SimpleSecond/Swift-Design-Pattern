//
//  main.swift
//  Adapter
//
//  Created by wdy on 2019/9/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation



//let url = "http://www.baidu.com/"
//let headers: [String] = ["Content-Length", "Content-Encoding"]
//
//let proxy = AccessControlProxy.init(url: url)
//
//for header in headers {
//    proxy.getHeader(header: header) { (head, val) in
//        if val != nil {
//            print("\(head) : \(val ?? "")")
//        }
//    }
//}
//
//UserAuthentication.sharedInstance.authenticate(user: "bob", pass: "secret")
//proxy.execute()


let queue = DispatchQueue.init(label: "requestQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: .none)

for count in 0..<3 {
    let connect = NetworkConnectionFactory.createNetwork()
    
    queue.async {
        connect.connect()
        connect.sendCommand(command: "\(count)")
        connect.disconnect()
    }
    
}




FileHandle.standardInput.availableData
