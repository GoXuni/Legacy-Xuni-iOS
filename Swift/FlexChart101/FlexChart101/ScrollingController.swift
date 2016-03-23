//
//  ScrollingController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class ScrollingController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Scrolling", comment: "")
        
        // Do any additional setup after loading the view.
        let precip = XuniSeries(forChart: _chart, binding: "precipitation", name: "Precip")
        let temp = XuniSeries(forChart: _chart, binding: "temp", name: "Temp")
        temp.chartType = XuniChartType.Spline
        let volume = XuniSeries(forChart: _chart, binding: "volume", name: "Volume")
        volume.chartType = XuniChartType.Spline
        
        let axisT = XuniAxis(position: XuniPosition.Right, forChart: _chart)
        axisT.min = 20
        axisT.max = 80
        axisT.majorUnit = 5
        axisT.title = "Volume"
        axisT.axisLineVisible = false
        axisT.majorGridVisible = false
        axisT.majorTickWidth = 0
        axisT.labelsVisible = true
        _chart.axesArray.addObject(axisT)
        
        _chart.chartType = XuniChartType.Column
        _chart.bindingX = "index"
        _chart.itemsSource = WeatherData.demoData()
        _chart.zoomMode = XuniZoomMode.X
        _chart.axisY.min = 4
        _chart.axisY.max = 20
        _chart.axisY.majorUnit = 2
        _chart.axisY.axisLineVisible = false
        _chart.axisY.majorTickWidth = 0
        _chart.axisX.labelAngle = 90
        _chart.axisX.majorGridVisible = false
        _chart.axisX.displayedRange = 10
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.palette = XuniPalettes.midnight()
        _chart.header = NSLocalizedString("Drag to scroll/Pinch to zoom", comment: "")
        _chart.headerFont = UIFont.systemFontOfSize(14)
        _chart.headerTextAlignment = XuniHorizontalAlignment.Center
        
        temp.axisY = axisT
        volume.axisY = axisT
        _chart.series.addObject(precip)
        _chart.series.addObject(temp)
        _chart.series.addObject(volume)

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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

