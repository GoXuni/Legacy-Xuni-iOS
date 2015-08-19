//
//  CustomizingAxesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class CustomizingAxesController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        
        _chart.axisX.title = "AAAAAA"
        _chart.axisY.lineWidth = 2
        _chart.axisY.majorTickWidth = 0
        _chart.axisY.majorGridColor = UIColor(red: 0.769 , green: 0.769, blue: 0.769, alpha: 1)
        _chart.axisY.axisLineVisible = true
        _chart.axisY.minorTickWidth = 1
        _chart.axisY.format = "c0"
        _chart.axisY.max = 10000
        _chart.axisY.majorUnit = 2000
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.tooltip.visible = true
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
