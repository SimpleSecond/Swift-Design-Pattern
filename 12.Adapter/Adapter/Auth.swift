//
//  Auth.swift
//  Adapter
//
//  Created by wdy on 2019/9/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class UserAuthentication {
    var user: String?
    var authenticated:Bool = false
    
    func authenticate(user: String, pass: String) -> Void {
        if pass == "secret" {
            self.user = user
            self.authenticated = true
        } else {
            self.user = nil
            self.authenticated = false
        }
    }
    
    // 单例模式
    private init() {
        // TODO
    }
    
    class var sharedInstance: UserAuthentication {
        get {
            struct singletonWrapper {
                static let singleton = UserAuthentication.init()
            }
            return singletonWrapper.singleton
        }
    }
}
