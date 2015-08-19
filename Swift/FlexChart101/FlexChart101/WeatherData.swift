//
//  WeatherData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class WeatherData: NSObject {
    var monthName: String
    var temp: Double
    var precipitation: Double
    
    init(monthName: String, temp: Double, precipitation: Double){
        self.monthName = monthName
        self.temp = temp
        self.precipitation = precipitation
    }
    class func demoData() -> NSMutableArray{
        var array = NSMutableArray()
        var monthNames = NSMutableArray()
        monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        for var i = 0; i < monthNames.count; i++ {
            var weather = WeatherData(monthName: monthNames.objectAtIndex(i) as! String, temp: tan(Double(i * i)) + 70, precipitation: Double((arc4random()%11) + 8))
            array.addObject(weather)
        }
        return array
    }
}
