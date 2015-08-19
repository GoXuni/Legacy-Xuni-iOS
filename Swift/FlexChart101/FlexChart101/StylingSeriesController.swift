//
//  StylingSeriesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class StylingSeriesController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        sales.color = UIColor.greenColor()
        sales.borderColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        sales.borderWidth = 2
        expenses.color = UIColor.redColor()
        expenses.borderColor = UIColor(red: 0.502, green: 0, blue: 0, alpha: 1)
        expenses.borderWidth = 2
        downloads.chartType = XuniChartType.LineSymbols
        downloads.color = UIColor(red: 1, green: 0.416, blue: 0, alpha: 1)
        downloads.borderWidth = 10
        downloads.symbolColor = UIColor.yellowColor()
        downloads.symbolBorderColor = UIColor.yellowColor()
        downloads.symbolBorderWidth = 5
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        
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
