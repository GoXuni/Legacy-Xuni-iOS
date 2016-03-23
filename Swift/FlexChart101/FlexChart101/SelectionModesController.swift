//
//  SelectionModesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class SelectionModesController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var _chart = FlexChart()
    var _chartTypePickerView = UIPickerView()
    var _chartTypePickerData = NSMutableArray()
    var _selectionModePickerView = UIPickerView()
    var _selectionModePickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Selection Modes", comment: "")
        
        // Do any additional setup after loading the view.
        _chartTypePickerData = ["Column", "Bar", "Scatter", "Line", "LineSymbol", "Area"]
        _chartTypePickerView.delegate = self
        _chartTypePickerView.showsSelectionIndicator = true
        _chartTypePickerView.hidden = false
        _chartTypePickerView.tag = 2
        
        _selectionModePickerData = ["None", "Series", "Point"]
        _selectionModePickerView.delegate = self
        _selectionModePickerView.showsSelectionIndicator = true
        _selectionModePickerView.hidden = false
        _selectionModePickerView.tag = 3
        _selectionModePickerView.selectRow(1, inComponent: 0, animated: false)
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.selectionMode = XuniSelectionMode.Series
        _chart.selectedBorderColor = UIColor.redColor()
        _chart.selectedBorderWidth = 3
        _chart.selectedDashes = [7.5, 2.5]
        
        self.view.addSubview(_chart)
        self.view.addSubview(_chartTypePickerView)
        self.view.addSubview(_selectionModePickerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chartTypePickerView.frame = CGRectMake(0, 44, self.view.bounds.size.width / 2, 162)
        _selectionModePickerView.frame = CGRectMake(self.view.bounds.size.width / 2, 44, self.view.bounds.size.width / 2, 162)
        _chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2){
            return _chartTypePickerData.count
        }
        else{
            return _selectionModePickerData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 2)
        {
            if (row == 0) {
                _chart.chartType = XuniChartType.Column
            }
            else if (row == 1){
                _chart.chartType = XuniChartType.Bar
            }
            else if (row == 2){
                _chart.chartType = XuniChartType.Scatter
            }
            else if (row == 3){
                _chart.chartType = XuniChartType.Line
            }
            else if (row == 4){
                _chart.chartType = XuniChartType.LineSymbols
            }
            else if (row == 5){
                _chart.chartType = XuniChartType.Area
            }
        }
        else if(pickerView.tag == 3){
            if (row == 0) {
                _chart.selectionMode = XuniSelectionMode.None
            }
            else if (row == 1){
                _chart.selectionMode = XuniSelectionMode.Series
            }
            else if (row == 2){
                _chart.selectionMode = XuniSelectionMode.Point
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 2)
        {
            return _chartTypePickerData.objectAtIndex(row) as! String
        }
        else if(pickerView.tag == 3){
            return _selectionModePickerData.objectAtIndex(row) as! String
        }
        else{
            return "error"
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
