//
//  AuthenticationManager.swift
//  22.Observer
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class AuthenticationManager: ShortLivedSubject {
    
    func authenticate(user: String, pass: String) -> Bool {
        var nType = NotificationTypes.AUTH_FAIL
        if user == "bob" && pass == "secret" {
            nType = .AUTH_SUCCESS
            print("User \(user) is authenticated")
        } else {
            print("Failed authenticated attempt")
        }
        sendNotification(notify: Notification.init(type: nType, data: user))
        return nType == .AUTH_SUCCESS
    }
    
}
