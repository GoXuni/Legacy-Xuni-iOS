//
//  FinancialData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class FinancialData: NSObject {
    var date: NSDate
    var open: Double
    var high: Double
    var low: Double
    var close: Double
    var volume: Double
    
    init(date: NSDate, open: Double, high: Double, low: Double, close: Double, volume: Double) {
        self.date = date
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
    }
    
    class func demoData() -> NSMutableArray {
        var array = NSMutableArray()
        var previousDate = NSDate()
        var now = NSDate()
        var open, high, low, close, volume : Double
        var yesterday : FinancialData
        
        for var i = 0; i < 25; i++ {
            if(i > 0){
                yesterday = array.objectAtIndex(i - 1) as! FinancialData
                open = yesterday.close
            }
            else{
                open = 1000
            }
            
            previousDate = now.dateByAddingTimeInterval(24 * 60 * 60 * Double(i))
            high = open + Double(arc4random() % 21)
            low = open - Double(arc4random() % 21)
            close = low + Double(arc4random() % UInt32(high == low ? 1 : high - low))
            volume = Double(arc4random() % 101)
            let finance = FinancialData(date: previousDate, open: open, high: high, low: low, close: close, volume: volume)
            array.addObject(finance)
        }
        
        return array
    }
}
