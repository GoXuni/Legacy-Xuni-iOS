//
//  DataLabelController.swift
//  FlexChart101
//
//  Created by Evangelists on 8/6/15.
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class DataLabelController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var _chart = FlexChart()
    var _chartTypePickerView = UIPickerView()
    var _chartTypePickerData = NSMutableArray()
    var _positionPickerView = UIPickerView()
    var _positionPickerData = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chartTypePickerData = ["Column", "Bar", "Scatter", "Line", "LineSymbol", "Area"]
        _chartTypePickerView.delegate = self
        _chartTypePickerView.showsSelectionIndicator = true
        _chartTypePickerView.hidden = false
        _chartTypePickerView.tag = 2
        
        _positionPickerData = ["Top", "Bottom", "Left", "Right", "None"]
        _positionPickerView.delegate = self
        _positionPickerView.showsSelectionIndicator = true
        _positionPickerView.hidden = false
        _positionPickerView.tag = 3
        
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        
        _chart.series.addObject(sales)
        
        _chart.itemsSource = ChartData.demoData()
        
        _chart.dataLabel.content = "{seriesName}\n{y}"
        _chart.dataLabel.dataLabelFormat = "C"
        _chart.dataLabel.position = FlexChartDataLabelPosition.Top
        _chart.dataLabel.dataLabelFontColor = UIColor.redColor()
        _chart.dataLabel.dataLabelBackgroundColor = UIColor.whiteColor()
        _chart.dataLabel.dataLabelBorderColor = UIColor.grayColor()
        _chart.dataLabel.dataLabelBorderWidth = 0.1
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
        self.view.addSubview(_chart)
        self.view.addSubview(_chartTypePickerView)
        self.view.addSubview(_positionPickerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _positionPickerView.frame = CGRectMake(self.view.bounds.size.width/2, 44, self.view.bounds.size.width/2, 162)
        _chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206)
        
        _chartTypePickerView.frame = CGRectMake(0, 44, self.view.bounds.size.width/2, 162)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2){
            return _chartTypePickerData.count
        }
        else{
            return _positionPickerData.count
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
                _chart.dataLabel.position = FlexChartDataLabelPosition.Top
            }
            else if (row == 1){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Bottom
            }
            else if (row == 2){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Left
            }
            else if (row == 3){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Right
            }
            else if (row == 4){
                _chart.dataLabel.position = FlexChartDataLabelPosition.None
            } 
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 2)
        {
            return _chartTypePickerData.objectAtIndex(row) as! String
        }
        else if(pickerView.tag == 3){
            return _positionPickerData.objectAtIndex(row) as! String
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
