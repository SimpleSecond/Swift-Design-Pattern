//
//  Transmitters.swift
//  ChainOfResp
//
//  Created by wdy on 2019/10/31.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


class Transmitter {
    var nextLink: Transmitter?
    
    required init() {}
    
    func sendMessage(message: Message, handled: Bool = false) -> Bool {
        if nextLink != nil {
            return nextLink!.sendMessage(message: message, handled: handled)
        } else if !handled {
            print("End of chain reached, Message not sent")
        }
        return handled
    }
    
    class func createChain(localOnly: Bool) -> Transmitter? {
        let transmitterClasses:[Transmitter.Type] = localOnly ? [PriorityTransmitter.self, LocalTransmitter.self] : [PriorityTransmitter.self, LocalTransmitter.self, RemoteTransmitter.self]
        
        var link: Transmitter?
        
        for tClass in transmitterClasses.reversed() {
            let existingLink = link
            link = tClass.init()
            link?.nextLink = existingLink
        }
        
        return link
    }
    
    fileprivate class func matchEmailSuffix(message: Message) -> Bool {
        if let index = message.from.firstIndex(of: "@") {
            return message.to.hasSuffix(message.from[index...])
        }
        return false
    }
    
}

class LocalTransmitter: Transmitter {
    
    override func sendMessage(message: Message, handled: Bool) -> Bool {
        var handled = handled
        if !handled && Transmitter.matchEmailSuffix(message: message) {
            print("Message to \(message.to) sent locally")
            handled = true
        }
        return super.sendMessage(message: message, handled: handled)
    }
    
}


class RemoteTransmitter: Transmitter {
    
    override func sendMessage(message: Message, handled: Bool) -> Bool {
        var handled = handled
        if !handled && !Transmitter.matchEmailSuffix(message: message) {
            print("Message to \(message.to) sent remotely")
            handled = true
        }
        return super.sendMessage(message: message, handled: handled)
    }
    
}


class PriorityTransmitter: Transmitter {
    
    var totalMessages = 0
    var handledMessages = 0
    
    override func sendMessage(message: Message, handled: Bool) -> Bool {
        var handled = handled
        totalMessages = totalMessages + 1
        if !handled && message.subject.hasPrefix("Priority") {
            handledMessages = handledMessages + 1
            print("Message to \(message.to) sent as priority")
            print("Status: Handled \(handledMessages) of \(totalMessages)")
            handled = true
        }
        return super.sendMessage(message: message, handled: handled)
    }
    
}
