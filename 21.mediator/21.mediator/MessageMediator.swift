//
//  MessageMediator.swift
//  21.mediator
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


protocol MessagePeer {
    var name: String {get}
    func handleMessage(messageType: String, data: Any?) -> Any?
    
}

class MessageMediator {
    private var peers = [String: MessagePeer].init()
    
    func registerPeer(peer: MessagePeer) {
        self.peers[peer.name] = peer
    }
    
    func unregisterPeer(peer:MessagePeer) {
        peers.removeValue(forKey: peer.name)
    }
    
    func sendMessage(celler: MessagePeer, messageType: String, data: Any) -> [Any?] {
        var result = [Any?].init()
        
        for peer in peers.values {
            if peer.name != celler.name {
                result.append(peer.handleMessage(messageType: messageType, data: data))
            }
        }
        
        return result
    }
}
