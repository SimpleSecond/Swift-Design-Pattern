//
//  Observer.swift
//  22.Observer
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

enum NotificationTypes: String {
    case AUTH_SUCCESS = "AUTH_SUCCESS"
    case AUTH_FAIL = "AUTH_FAIL"
    case SUBJECT_CREATED = "SUBJECT_CREATED"
    case SUBJECT_DESTROYED = "SUBJECT_DESTROYED"
}

class Notification {
    let type: NotificationTypes
    let data: Any?
    
    init(type: NotificationTypes, data: Any?) {
        self.type = type
        self.data = data
    }
}

class AuthenticationNotification: Notification {
    
    init(user: String, success: Bool) {
        super.init(type: success ? .AUTH_SUCCESS : .AUTH_FAIL, data: user)
    }
    
    var userName: String? {
        get {
            return self.data as! String?
        }
    }
    
    var requestSuccessed: Bool {
        get {
            return self.type == .AUTH_SUCCESS
        }
    }
}


protocol Observer: class {
    func notify(notification: Notification)
}

protocol Subject {
    func addObservers(observers: Observer...)
    func removeObserver(observer: Observer)
}

class WeakObserverReference {
    weak var observer: Observer?
    init(observer: Observer) {
        self.observer = observer
    }
}


class SubjectBase: Subject {
    private var observers = [WeakObserverReference].init()
    private var collectionQueue = DispatchQueue.init(label: "colQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    func addObservers(observers: Observer...) {
        self.collectionQueue.sync(flags: .barrier) { () -> Void in
            for newOb in observers {
                self.observers.append(WeakObserverReference.init(observer: newOb))
            }
        }
    }
    
    func removeObserver(observer: Observer) {
        self.collectionQueue.sync(flags: .barrier) { () -> Void in
            self.observers = self.observers.filter({ (weakRef) -> Bool in
                return weakRef.observer != nil && weakRef.observer !== observer
            })
        }
    }
    
    func sendNotification(notify: Notification) {
        self.collectionQueue.sync {
            for ob in self.observers {
                ob.observer?.notify(notification: notify)
            }
        }
    }
    
}
