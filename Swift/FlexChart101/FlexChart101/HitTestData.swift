//
//  HitTestData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class HitTestData: NSObject {
    var x: Double
    var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y

    }
    
    class func cosData() -> NSMutableArray {
        var cosData = NSMutableArray()

        for var i = 0; i < 40; i++ {
            let cosPoint = HitTestData(x: Double(i), y: cos(Double(i) * 0.12))
            cosData.addObject(cosPoint)
        }
        return cosData
    }
    
    class func sinData() -> NSMutableArray {
        var sinData = NSMutableArray()
        
        for var i = 0; i < 40; i++ {
            let sinPoint = HitTestData(x: Double(i), y: sin(Double(i) * 0.12))
            sinData.addObject(sinPoint)
        }
        return sinData
    }
}
