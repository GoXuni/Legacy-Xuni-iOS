//
//  WeatherData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class WeatherData: NSObject {
    var monthName: String
    var index: Int
    var temp: Double
    var precipitation: Double
    var volume: Double
    
    init(monthName: String, index: Int, temp: Double, precipitation: Double, volume: Double) {
        self.monthName = monthName
        self.index = index
        self.temp = temp
        self.precipitation = precipitation
        self.volume = volume
    }
    
    class func demoData() -> NSMutableArray {
        var array = NSMutableArray()
        var monthNames = NSMutableArray()
        monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        for var i = 0; i < monthNames.count; i++ {
            var weather = WeatherData(monthName: monthNames.objectAtIndex(i) as! String,
                index: i,
                temp: tan(Double(i * i)) + 70,
                precipitation: Double((arc4random() % 11) + 8),
                volume:Double((arc4random() % 51) + 29))
            
            array.addObject(weather)
        }
        return array
    }
}
