//
//  BasicChartTypesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class BasicChartTypesController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var _chart = FlexChart()
    var _chartTypePickerView = UIPickerView()
    var _chartTypePickerData = NSMutableArray()
    var _stackingPickerView = UIPickerView()
    var _stackingPickerData = NSMutableArray()
    var _rotatedSwitch = UISwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _rotatedSwitch.addTarget(self, action: "switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        _chartTypePickerData = ["Column", "Bar", "Scatter", "Line", "LineSymbol", "Area"]
        _chartTypePickerView.delegate = self
        _chartTypePickerView.showsSelectionIndicator = true
        _chartTypePickerView.hidden = false
        _chartTypePickerView.tag = 2
        
        _stackingPickerData = ["None", "Stacked", "Stacked100pc"]
        _stackingPickerView.delegate = self
        _stackingPickerView.showsSelectionIndicator = true
        _stackingPickerView.hidden = false
        _stackingPickerView.tag = 3
        
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
        self.view.addSubview(_chart)
        self.view.addSubview(_rotatedSwitch)
        self.view.addSubview(_chartTypePickerView)
        self.view.addSubview(_stackingPickerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _stackingPickerView.frame = CGRectMake(self.view.bounds.size.width*7/18, 44, self.view.bounds.size.width*4/9, 162)
        _chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206)
        _rotatedSwitch.frame = CGRectMake((self.view.bounds.size.width * 15/18) + 5, 110, self.view.bounds.size.width*3/18, 50)

        _chartTypePickerView.frame = CGRectMake(0, 44, self.view.bounds.size.width*7/18, 162)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2){
            return _chartTypePickerData.count
        }
        else{
            return _stackingPickerData.count
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
                _chart.stacking = XuniStacking.None
            }
            else if (row == 1){
                _chart.stacking = XuniStacking.Stacked
            }
            else if (row == 2){
                _chart.stacking = XuniStacking.Stacked100pc
            }
        }
        setAxisFormatting()
    }
    func setAxisFormatting(){
        if (_chart.chartType == XuniChartType.Bar) {
            if (_chart.stacking == XuniStacking.Stacked100pc  && _chart.rotated == false) {
                _chart.axisX.format = "p"
                _chart.axisY.format = "d"
            }
            else if (_chart.stacking == XuniStacking.Stacked100pc  && _chart.rotated == true){
                _chart.axisX.format = "d"
                _chart.axisY.format = "p"
            }
            else{
                _chart.axisX.format = "d"
                _chart.axisY.format = "d"
            }
        }
        else{
            if(_chart.stacking == XuniStacking.Stacked100pc && _chart.rotated == false){
                _chart.axisX.format = "d"
                _chart.axisY.format = "p"
            }
            else if(_chart.stacking == XuniStacking.Stacked100pc && _chart.rotated == true){
                _chart.axisX.format = "p"
                _chart.axisY.format = "d"
            }
            else{
                _chart.axisX.format = "d"
                _chart.axisY.format = "d"
            }
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 2)
        {
            return _chartTypePickerData.objectAtIndex(row) as! String
        }
        else if(pickerView.tag == 3){
            return _stackingPickerData.objectAtIndex(row) as! String
        }
        else{
            return "error"
        }
    }
    
    func switchChanged(switchState: UISwitch) {
        var temp = String()
        if (switchState.on) {
            _chart.rotated = true
        }
        else
        {
            _chart.rotated = false
        }
        temp = _chart.axisX.format
        _chart.axisX.format = _chart.axisY.format
        _chart.axisY.format = temp
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
