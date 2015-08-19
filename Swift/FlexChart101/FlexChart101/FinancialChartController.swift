//
//  FinancialChartController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class FinancialChartController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _pickerView = UIPickerView()
    var _pickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _pickerData = ["Candlestick", "HLOC"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
        _chart.bindingX = "date"
        
        let finance = XuniSeries(forChart: _chart, binding: "high,low,open,close", name: "AAPL")

        
        _chart.series.addObject(finance)

        _chart.itemsSource = FinancialData.demoData()
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.chartType = XuniChartType.Candlestick
        _chart.tooltip.visible = true
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
        self.view.addSubview(_chart)
        self.view.addSubview(_pickerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, (self.view.bounds.size.height-206))
        _pickerView.frame = CGRectMake(self.view.bounds.size.width/4, 44, self.view.bounds.size.width/2, 162)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (row) {
        case 0:
            _chart.chartType = XuniChartType.Candlestick
        case 1:
            _chart.chartType = XuniChartType.HighLowOpenClose
        default:
            break
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return _pickerData.objectAtIndex(row) as! String
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

