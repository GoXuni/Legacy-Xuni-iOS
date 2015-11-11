//
//  DynamicChartData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class DynamicChartData: NSObject {
    var time: String
    var trucks: Int
    var ships: Int
    var planes: Int
    
    init(time: String, trucks: Int, ships: Int, planes: Int) {
        self.time = time
        self.trucks = trucks
        self.ships = ships
        self.planes = planes
    }
    
    class func randomNumberBetween(min: Int, max: Int) -> Int {
        return (min + Int(rand()) % (max - min + 1));
    }
    
    class func getOneData() -> DynamicChartData {
        var num = DynamicChartData.randomNumberBetween(0, max: 1000)
        
        while num < 900 {
            num = DynamicChartData.randomNumberBetween(0, max: 1000)
        }
        
        var trucks = num + 20
        var ships = num + 10
        var planes = num
        var dateFormat = NSDateFormatter()
        var d = NSDate(timeIntervalSinceNow: 0)
        dateFormat.dateFormat = "mm:ss"
        
        return DynamicChartData(time: dateFormat.stringFromDate(d), trucks: trucks, ships: ships, planes: planes)
    }
    
    class func demoData() -> NSMutableArray {
        var array = NSMutableArray()
        
        for var i = 0; i < 8; i++ {
            array.addObject(DynamicChartData.getOneData())
        }
        
        return array
    }
    
    class func dynamicData(array : NSMutableArray) -> NSMutableArray {
        if(array.count > 30){
            array.removeObjectAtIndex(0)
        }
        
        array.addObject(DynamicChartData.getOneData())
        
        return array
    }
}
