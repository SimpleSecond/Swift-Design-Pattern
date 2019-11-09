//
//  Proxy.swift
//  Adapter
//
//  Created by wdy on 2019/9/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


protocol HttpHeaderRequest {
    
    init(url: String)
    func getHeader(header: String, callback: @escaping (String, String?) -> Void)
    func execute()
    
}

class AccessControlProxy: HttpHeaderRequest {
    
    private let wrappedObject : HttpHeaderRequest;
    
    required init(url: String) {
        wrappedObject = HttpHeaderRequestProxy.init(url: url)
    }
    
    func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
        wrappedObject.getHeader(header: header, callback: callback)
    }
    
    func execute() {
        if UserAuthentication.sharedInstance.authenticated {
            wrappedObject.execute()
        } else {
            fatalError("Unauthorized")
        }
    }
    
}


// Protocol 代理实现
class HttpHeaderRequestProxy: HttpHeaderRequest {
    let url: String
    var headersRequired: [String: (String, String?) -> Void]
    
    private let semaphore = DispatchSemaphore.init(value: 0)
    
    
    required init(url: String) {
        self.url = url
        self.headersRequired = Dictionary<String, (String, String?) -> Void>.init()
    }
    
    func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
        self.headersRequired[header] = callback
    }
    
    func execute() {
        let nsUrl: URL = URL.init(string: url)!
        let request: URLRequest = URLRequest.init(url: nsUrl)
        
        URLSession.shared.dataTask(with: request) { (data, resp, error) in
            if let httpResp = resp as? HTTPURLResponse {
                let headers = httpResp.allHeaderFields as! [String: String]
                for (header, callback) in self.headersRequired {
                    callback(header, headers[header])
                }
            }
            //self.semaphore.signal()
        }.resume()
        //self.semaphore.wait()
    }
    
}
