//
//  LegendAndTitlesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class LegendAndTitlesController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Legend and Titles", comment: "")
        
        // Do any additional setup after loading the view.
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.chartType = XuniChartType.Scatter;
        
        _chart.header = "Sample Chart"
        _chart.headerTextColor = UIColor(red: 0.502, green: 0.016, blue: 0.302, alpha: 1)
        _chart.headerFont = UIFont.boldSystemFontOfSize(24.0)
        _chart.headerTextAlignment = XuniHorizontalAlignment.Center
        _chart.footer = "2015 GrapeCity, Inc."
        _chart.footerTextColor = UIColor(red: 0.502, green: 0.016, blue: 0.302, alpha: 1)
        _chart.footerFont = UIFont.systemFontOfSize(16.0)
        _chart.footerTextAlignment = XuniHorizontalAlignment.Center
        
        _chart.axisX.title = "Country";
        _chart.axisX.titleFont = UIFont.boldSystemFontOfSize(16.0)
        _chart.axisX.titleFont = UIFont.italicSystemFontOfSize(16.0)
        _chart.axisX.majorGridVisible = true
        _chart.axisY.title = "Amount"
        _chart.axisY.titleFont = UIFont.boldSystemFontOfSize(16.0)
        _chart.axisY.titleFont = UIFont.italicSystemFontOfSize(16.0)
        _chart.axisY.format = "C0"
        
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
