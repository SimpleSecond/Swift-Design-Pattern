//
//  main.swift
//  20.command
//
//  Created by wdy on 2019/11/2.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


let calc = Calculator.init()
calc.add(amount: 10)
calc.multiply(amount: 4)
calc.subtract(amount: 2)
print("Calc 1 Total: \(calc.total)")


let macro = calc.getMacroCommand()

let calc2 = Calculator.init()
macro(calc2)
print("Calc 2 Total: \(calc2.total)")



//let cache = NSCache<NSString, NSPurgeableData>.init()
//let tempData = "This".data(using: .utf8)
//let data = NSPurgeableData.init(data: tempData!)
//data.beginContentAccess()
//
//let urlStr = "https://www.baidu.com/"
//
//cache.setObject(data, forKey: urlStr as NSString, cost: data.length)
//data.endContentAccess()
//
//
//let outCacheData = cache.object(forKey: urlStr as NSString)
//outCacheData?.beginContentAccess()
//let outData = outCacheData!.subdata(with: NSRange.init(location: 0, length: data.length))
//outCacheData?.endContentAccess()
//
//
//let outStr = String.init(data: outData, encoding: .utf8)
//print(outStr!)


//let cacheData = cache.object(forKey: urlStr as NSString)
//let strData = String.init(data: cacheData! as Data, encoding: .utf8)
//cacheData?.endContentAccess()
//
//
//print(strData)

