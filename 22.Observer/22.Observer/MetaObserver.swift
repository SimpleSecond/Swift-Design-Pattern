//
//  MetaObserver.swift
//  22.Observer
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol MetaObserver: Observer {
    func notifySubjectCreated(subj: Subject)
    func notifySubjectDestroyed(subj: Subject)
}

class MetaSubject: SubjectBase, MetaObserver {
    func notifySubjectCreated(subj: Subject) {
        sendNotification(notify: Notification.init(type: .SUBJECT_CREATED, data: subj))
    }
    
    func notifySubjectDestroyed(subj: Subject) {
        sendNotification(notify: Notification.init(type: .SUBJECT_DESTROYED, data: subj))
    }
    
    func notify(notification: Notification) {
        //
    }
    
    class var sharedInstance: MetaSubject {
        struct singletonWrapper {
            static let singleton = MetaSubject.init()
        }
        return singletonWrapper.singleton
    }
    
}

class ShortLivedSubject: SubjectBase {
    override init() {
        super.init()
        MetaSubject.sharedInstance.notifySubjectCreated(subj: self)
    }
    
    deinit {
        MetaSubject.sharedInstance.notifySubjectDestroyed(subj: self)
    }
}
