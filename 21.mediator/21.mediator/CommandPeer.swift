//
//  CommandPeer.swift
//  21.mediator
//
//  Created by wdy on 2019/11/6.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol CommandPeer {
    var name:String {get}
    
}

class Command {
    let function: (CommandPeer) -> Any
    
    init(function: @escaping (CommandPeer) -> Any) {
        self.function = function
    }
    
    func execute(peer: CommandPeer) -> Any {
        return function(peer)
    }
}

class CommandMediator {
    private var peers = [String: CommandPeer].init()
    
    func registerPeer(peer: CommandPeer) {
        peers[peer.name] = peer
    }
    
    func unregisterPeer(peer: CommandPeer) {
        peers.removeValue(forKey: peer.name)
    }
    
    func dispatchCommand(cellar: CommandPeer, command: Command) -> [Any] {
        var results = [Any].init()
        
        for peer in peers.values {
            if peer.name != cellar.name {
                results.append(command.execute(peer: peer ))
            }
        }
        
        return results
    }
    
}
