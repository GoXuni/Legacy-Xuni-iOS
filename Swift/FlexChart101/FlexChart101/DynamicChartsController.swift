//
//  DynamicChartsController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class DynamicChartsController: UIViewController {
    
    var _chart = FlexChart()
    var _chartData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Dynamic Charts", comment: "")
        
        // Do any additional setup after loading the view.
        let trucks = XuniSeries(forChart: _chart, binding: "trucks, trucks", name: "Trucks")
        let sales = XuniSeries(forChart: _chart, binding: "ships, ships", name: "Ships")
        let planes = XuniSeries(forChart: _chart, binding: "planes, planes", name: "Planes")
        
        _chart.series.addObject(trucks)
        _chart.series.addObject(sales)
        _chart.series.addObject(planes)
        
        _chartData = DynamicChartData.demoData()
        _chart.itemsSource = _chartData
        _chart.bindingX = "time"
        _chart.chartType = XuniChartType.Line
        _chart.tooltip.isVisible = false
        _chart.palette = XuniPalettes.coral()
        
        var d = NSDate(timeIntervalSinceNow: _chart.loadAnimation.duration + 0.1)
        var timer = NSTimer(fireDate: d, interval: 1, target: self, selector: Selector("onTick"), userInfo: nil, repeats: true)
        var runner = NSRunLoop.currentRunLoop()
        runner.addTimer(timer, forMode: NSDefaultRunLoopMode)
        
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
    
    func onTick() {
        _chart.isAnimated = false
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
