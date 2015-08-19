//
//  PieChartData.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class PieChartData: NSObject {
    var name: String
    var value: Double
    
    init(name: String, value: Double){
        self.name = name
        self.value = value
    }
    class func demoData() -> NSMutableArray{
        return[
            PieChartData(name: "Oranges", value: Double(arc4random()%101)),
            PieChartData(name: "Apples", value: Double(arc4random()%101)),
            PieChartData(name: "Pears", value: Double(arc4random()%101)),
            PieChartData(name: "Bananas", value: Double(arc4random()%101)),
            PieChartData(name: "Pineapples", value: Double(arc4random()%101))
        ]
    }
}
