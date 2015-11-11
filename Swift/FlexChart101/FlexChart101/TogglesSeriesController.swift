//
//  TogglesSeriesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class TogglesSeriesController: UIViewController {
    
    var _chart = FlexChart()
    var _salesSwitch = UISwitch()
    var _expensesSwitch = UISwitch()
    var _downloadsSwitch = UISwitch()
    var _salesLabel = UILabel()
    var _expensesLabel = UILabel()
    var _downloadsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Toggle Series"
        
        // Do any additional setup after loading the view.
        
        _salesLabel.text = "Sales"
        _expensesLabel.text = "Expenses"
        _downloadsLabel.text = "Downloads"
        
        _salesSwitch.addTarget(self, action: "salesSwitchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        _expensesSwitch.addTarget(self, action: "expensesSwitchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        _downloadsSwitch.addTarget(self, action: "downloadsSwitchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        _salesSwitch.on = true
        _expensesSwitch.on = true
        _downloadsSwitch.on = true
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.chartType = XuniChartType.LineSymbols
        _chart.selectionMode = XuniSelectionMode.Series
        
        self.view.addSubview(_chart)
        self.view.addSubview(_salesSwitch)
        self.view.addSubview(_expensesSwitch)
        self.view.addSubview(_downloadsSwitch)
        self.view.addSubview(_salesLabel)
        self.view.addSubview(_expensesLabel)
        self.view.addSubview(_downloadsLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _chart.frame = CGRectMake(0, self.view.bounds.size.height * 2 / 8, self.view.bounds.size.width, self.view.bounds.size.height - (self.view.bounds.size.height * 2 / 8))
        _salesSwitch.frame = CGRectMake(self.view.bounds.size.width / 12, self.view.bounds.size.height * 3 / 16, self.view.bounds.size.width / 6, self.view.bounds.size.height / 16)
        _expensesSwitch.frame = CGRectMake(self.view.bounds.size.width / 2 - self.view.bounds.size.width / 12, self.view.bounds.size.height * 3 / 16, self.view.bounds.size.width / 6, self.view.bounds.size.height / 16)
        _downloadsSwitch.frame = CGRectMake(self.view.bounds.size.width * 3 / 4, self.view.bounds.size.height * 3 / 16, self.view.bounds.size.width / 6, self.view.bounds.size.height / 16)
        _salesLabel.frame = CGRectMake(self.view.bounds.size.width / 12, self.view.bounds.size.height / 8, self.view.bounds.size.width / 6, self.view.bounds.size.height / 16)
        _expensesLabel.frame = CGRectMake(self.view.bounds.size.width / 2 - self.view.bounds.size.width / 12, self.view.bounds.size.height / 8, self.view.bounds.size.width / 6, self.view.bounds.size.height / 16)
        _downloadsLabel.frame = CGRectMake(self.view.bounds.size.width * 3 / 4, self.view.bounds.size.height / 8, self.view.bounds.size.width / 6, self.view.bounds.size.height / 16)
        
        _salesLabel.sizeToFit()
        _expensesLabel.sizeToFit()
        _downloadsLabel.sizeToFit()
    }
    
    func salesSwitchChanged(switchState: UISwitch) {
        if (switchState.on) {
            (_chart.series.objectAtIndex(0) as! XuniSeries).visibility = XuniSeriesVisibility.Visible
        }
        else{
            (_chart.series.objectAtIndex(0) as! XuniSeries).visibility = XuniSeriesVisibility.Hidden
        }
    }
    
    
    func expensesSwitchChanged(switchState: UISwitch) {
        var series = _chart.series.objectAtIndex(1) as! XuniSeries
        if (switchState.on) {
            (_chart.series.objectAtIndex(1) as! XuniSeries).visibility = XuniSeriesVisibility.Visible
        }
        else{
            (_chart.series.objectAtIndex(1) as! XuniSeries).visibility = XuniSeriesVisibility.Hidden
        }
    }
    
    
    func downloadsSwitchChanged(switchState: UISwitch) {
        var series = _chart.series.objectAtIndex(2) as! XuniSeries
        if (switchState.on) {
            (_chart.series.objectAtIndex(2) as! XuniSeries).visibility = XuniSeriesVisibility.Visible
        }
        else{
            (_chart.series.objectAtIndex(2) as! XuniSeries).visibility = XuniSeriesVisibility.Hidden
        }
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
