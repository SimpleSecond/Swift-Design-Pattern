//
//  Mediator.swift
//  21.mediator
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol Peer {
    var name : String {get}
    var currentPosition: Position {get}
    func otherPlaneDidChangePosition(position: Position) -> Bool
}

protocol Mediator {
    func registerPeer(peer: Peer)
    func unregisterPeer(peer: Peer)
    func changePosition(peer: Peer, pos: Position) -> Bool
    
}

class AirplaneMediator: Mediator {
    
    private var peers: [String: Peer]
    private let queue = DispatchQueue.init(label: "dictQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    init() {
        self.peers = [String: Peer].init()
    }
    
    
    func registerPeer(peer: Peer) {
        self.queue.sync(flags: DispatchWorkItemFlags.barrier) { () -> Void in
            self.peers[peer.name] = peer
        }
    }
    
    func unregisterPeer(peer: Peer) {
        self.queue.sync(flags: DispatchWorkItemFlags.barrier) { () -> Void in
            let _ = self.peers.removeValue(forKey: peer.name)
            
        }
    }
    
    func changePosition(peer: Peer, pos: Position) -> Bool {
        var result = false
        self.queue.sync {
            let closePeers = self.peers.values.filter { (p) -> Bool in
                return p.currentPosition.distanceFromRunway <= pos.distanceFromRunway
            }
            
            for storedPeer in closePeers {
                if (peer.name != storedPeer.name && storedPeer.otherPlaneDidChangePosition(position: pos)) {
                    result = true
                }
            }
        }
        
        return result
    }
    
    
}
