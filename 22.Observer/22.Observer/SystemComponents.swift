//
//  SystemComponents.swift
//  22.Observer
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class ActivityLog: Observer {
    func notify(notification: Notification) {
        print("Auth request for \(notification.type) Success: \(notification.data!)")
    }
    
    func logActivity(activity: String) -> Void {
        print("Log: \(activity)")
    }
}

class FileCache: Observer {
    func notify(notification: Notification) {
        if let authNotif = notification as? AuthenticationNotification {
            if authNotif.requestSuccessed && authNotif.userName != nil {
                loadFiles(user: authNotif.userName!)
            }
        }
    }
    
    func loadFiles(user: String) {
        print("Load files for \(user)")
    }
}

class AttachMonitor: MetaObserver {
    func notifySubjectCreated(subj: Subject) {
        if subj is AuthenticationManager {
            subj.addObservers(observers: self)
        }
    }
    
    func notifySubjectDestroyed(subj: Subject) {
        subj.removeObserver(observer: self)
    }
    
    func notify(notification: Notification) {
        monitorSuspiciousActivity = (notification.type == .AUTH_FAIL)
    }
    
    var monitorSuspiciousActivity: Bool = false {
        didSet {
            print("Monitoring for attack: \(self.monitorSuspiciousActivity)")
        }
    }
    
}
