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
    
    init(name: String, sales: Double, expenses: Double, downloads: Double){
        self.name = name
        self.sales = sales
        self.expenses = expenses
        self.downloads = downloads
    }
    class func demoData() -> NSMutableArray{
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