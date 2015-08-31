//
//  MultipleAxesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class MultipleAxesController: UIViewController {
  
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chart.bindingX = "monthName"
        
        var precip = XuniSeries(forChart: _chart, binding: "precipitation, precipitation", name: "Precip")
        var temp = XuniSeries(forChart: _chart, binding: "temp, temp", name: "Avg. Temp")
    
        var axisT = XuniAxis(position: XuniPosition.Right, forChart: _chart)
        axisT.min = 0
        axisT.max = 80
        axisT.majorUnit = 10
        axisT.title = "Avg. Temperature (F)"
        axisT.axisLineVisible = false
        axisT.majorGridVisible = false
        axisT.majorGridWidth = 1
        axisT.minorTickWidth = 0
        axisT.titleTextColor = UIColor(red: 0.984, green: 0.698, blue: 0.345, alpha: 1)
        axisT.labelsVisible = true
        _chart.axesArray.addObject(axisT)
        
        _chart.axisY.min = 4
        _chart.axisY.max = 20
        _chart.axisY.majorUnit = 2
        _chart.axisY.title = "Precipitation (in)"
        _chart.axisY.axisLineVisible = false
        _chart.axisY.majorTickWidth = 1
        _chart.axisY.minorTickWidth = 0
        _chart.axisY.titleTextColor = UIColor(red: 0.533, green: 0.741, blue: 0.902, alpha: 1)
        _chart.axisX.labelAngle = 90
        _chart.axisX.majorGridVisible = false
        temp.chartType = XuniChartType.Spline

        _chart.series.addObject(precip)
        _chart.series.addObject(temp)
        
        _chart.itemsSource = WeatherData.demoData()
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        _chart.legend.position = XuniChartLegendPosition.None
        
        (_chart.series.objectAtIndex(1) as! XuniSeries).axisY = axisT
        _chart.tooltip.isVisible = true
        
        self.view.addSubview(_chart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chart.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65)
    }

}
