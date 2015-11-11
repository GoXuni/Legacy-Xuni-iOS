//
//  FinancialChartController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class FinancialChartController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _pickerView = UIPickerView()
    var _pickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Financial Chart"
        
        // Do any additional setup after loading the view.
        _pickerData = ["Candlestick", "HLOC"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
        let finance = XuniSeries(forChart: _chart, binding: "high,low,open,close", name: "AAPL")
        
        _chart.series.addObject(finance)

        _chart.itemsSource = FinancialData.demoData()
        _chart.bindingX = "date"
        _chart.legend.position = XuniChartLegendPosition.None
        _chart.chartType = XuniChartType.Candlestick
        _chart.selectionMode = XuniSelectionMode.Point;
        _chart.axisY.majorGridFill = UIColor(white: 0.6, alpha: 0.2);
        
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

