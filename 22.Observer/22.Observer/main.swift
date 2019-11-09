//
//  main.swift
//  22.Observer
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

let monitor = AttachMonitor.init()
MetaSubject.sharedInstance.addObservers(observers: monitor)

//
let log = ActivityLog.init()
let cache = FileCache.init()

let authM = AuthenticationManager.init()

authM.addObservers(observers: cache, monitor)

authM.authenticate(user: "bob", pass: "secret")
print("------")
authM.authenticate(user: "joe", pass: "shit")







//class Subject: NSObject {
//    dynamic var counter = 0
//}
//
//class Observer: NSObject {
//
//    init(subject: Subject) {
//        super.init()
//        subject.addObserver(self, forKeyPath: "counter", options: NSKeyValueObservingOptions.new, context: nil)
//    }
//
//    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print("Notification: \(keyPath) = \(change![NSKeyValueChangeKey.newKey])")
//    }
//
//}
//
//let subject = Subject.init()
//let observer = Observer.init(subject: subject)
//
//
//subject.counter = 9
//subject.counter = 22
