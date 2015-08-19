//
//  DynamicChartData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class DynamicChartData: NSObject {
    var time: Double
    var trucks: Double
    var ships: Double
    var planes: Double
    
    init(time: Double, trucks: Double, ships: Double, planes: Double){
        self.time = time
        self.trucks = trucks
        self.ships = ships
        self.planes = planes
    }
    class func demoData() -> NSMutableArray{
        var array = NSMutableArray()
        for var i = 0; i < 8; i++ {
            let dynamic = DynamicChartData(time: Double(i), trucks: Double(920 + arc4random() % 101), ships: Double(910 + arc4random() % 101), planes: Double(900 + arc4random() % 101))
            array.addObject(dynamic)
        }
        return array
    }
    class func dynamicData(array : NSMutableArray) -> NSMutableArray{
        if(array.count > 8){
            array.removeObjectAtIndex(0)
        }
        
        var d = array.objectAtIndex(7) as! DynamicChartData
        
        let dynamic = DynamicChartData(time: Double(d.time + 1), trucks: Double(920 + arc4random() % 101), ships: Double(910 + arc4random() % 101), planes: Double(900 + arc4random() % 101))
        array.addObject(dynamic)
        
        return array
    }
}
