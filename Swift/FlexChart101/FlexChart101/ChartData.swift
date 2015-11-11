//
//  ChartData.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ChartData: NSObject {
    var name: String
    var sales: Double
    var expenses: Double
    var downloads: Double
    
    init(name: String, sales: Double, expenses: Double, downloads: Double) {
        self.name = name
        self.sales = sales
        self.expenses = expenses
        self.downloads = downloads
    }
    
    class func demoData() -> NSMutableArray {
        return[
            ChartData(name: "US", sales: Double(arc4random()%10001), expenses: Double(arc4random()%5001), downloads: Double(arc4random()%20001)),
            ChartData(name: "Germany", sales: Double(arc4random()%10001), expenses: Double(arc4random()%5001), downloads: Double(arc4random()%20001)),
            ChartData(name: "UK", sales: Double(arc4random()%10001), expenses: Double(arc4random()%5001), downloads: Double(arc4random()%20001)),
            ChartData(name: "Japan", sales: Double(arc4random()%10001), expenses: Double(arc4random()%5001), downloads: Double(arc4random()%20001)),
            ChartData(name: "Italy", sales: Double(arc4random()%10001), expenses: Double(arc4random()%5001), downloads: Double(arc4random()%20001)),
            ChartData(name: "Greece", sales: Double(arc4random()%10001), expenses: Double(arc4random()%5001), downloads: Double(arc4random()%20001))
        ]
    }
}

class ChartPoint : NSObject {
    var x: Double
    var y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    class func generateRandomPoints(count: Int) -> NSMutableArray {
        var points = NSMutableArray()
        var innerCount = count
        
        if innerCount % 2 == 1 {
            innerCount++
        }
        
        for var i = 0; i < innerCount / 2; i++ {
            do
            {
                var random: Double = Double(rand()) / Double(RAND_MAX)
                var u: Double = 2 * random - 1
                var v: Double = 2 * random - 1
                
                var s: Double = u * u + v * v
                
                if s < 1
                {
                    s = sqrt(-2 * log(s) / s)
                    points.addObject(ChartPoint(x: Double(i), y: (u * s)))
                    points.addObject(ChartPoint(x: Double(i + 1), y: (v * s)))
                    break
                }
            } while true
        }
        
        return points
    }
}
