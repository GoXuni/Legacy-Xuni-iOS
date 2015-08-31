//
//  DynamicChartsController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class DynamicChartsController: UIViewController {
    
    var _chart = FlexChart()
    var _chartData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chart.bindingX = "time"
        
        let trucks = XuniSeries(forChart: _chart, binding: "trucks, trucks", name: "Trucks")
        let sales = XuniSeries(forChart: _chart, binding: "ships, ships", name: "Ships")
        let planes = XuniSeries(forChart: _chart, binding: "planes, planes", name: "Planes")
        
        _chart.series.addObject(trucks)
        _chart.series.addObject(sales)
        _chart.series.addObject(planes)
        
        _chartData = DynamicChartData.demoData()
        _chart.itemsSource = _chartData
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.chartType = XuniChartType.Line
        _chart.loadAnimation.duration = 0
        _chart.tooltip.isVisible = true
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTick", userInfo: nil, repeats: true)
        
        self.view.addSubview(_chart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chart.frame = CGRectMake(0, 55, self.view.bounds.size.width, self.view.bounds.size.height - 55)
    }
    func onTick(){
        _chart.itemsSource = DynamicChartData.dynamicData(_chartData)
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
