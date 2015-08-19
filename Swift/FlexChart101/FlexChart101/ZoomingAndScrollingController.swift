//
//  ZoomingAndScrollingController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class ZoomingAndScrollingController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _pickerView = UIPickerView()
    var _pickerData = NSMutableArray()
    var _label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _pickerData = ["X", "Y", "XY", "Disabled"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
        _label.text = "Zoom Mode"
        
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        
        _chart.axisX.scale = 0.5
        _chart.axisY.displayedRange = 16000
        _chart.chartType = XuniChartType.Area
        _chart.stacking = XuniStacking.Stacked
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.tooltip.visible = true
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true

        self.view.addSubview(_chart)
        self.view.addSubview(_pickerView)
        self.view.addSubview(_label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _label.frame = CGRectMake(10, 110, 50, 25)
        _label.sizeToFit()
        _pickerView.frame = CGRectMake(self.view.bounds.size.width/3, 44, self.view.bounds.size.width/2, 162)
        _chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
            _chart.zoomMode = XuniZoomMode.X
        }
        else if (row == 1){
            _chart.zoomMode = XuniZoomMode.Y
        }
        else if (row == 2){
            _chart.zoomMode = XuniZoomMode.XY
        }
        else if (row == 3){
            _chart.zoomMode = XuniZoomMode.Disabled
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

