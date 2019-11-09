//
//  PoolItem.swift
//  08.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

protocol PoolItem {
    var canReuse: Bool {get}
}
