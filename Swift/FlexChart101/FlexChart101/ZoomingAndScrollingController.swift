//
//  ZoomingAndScrollingController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class ZoomingAndScrollingController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _pickerView = UIPickerView()
    var _pickerData = NSMutableArray()
    var _label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Zooming and Scrolling", comment: "")
        
        // Do any additional setup after loading the view.
        _pickerData = ["X", "Y", "XY", "Disabled"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        _pickerView.selectRow(2, inComponent: 0, animated: false)
        _label.text = "Zoom Mode"
        
        let sales = XuniSeries(forChart: _chart, binding: "y", name: "Normal Distribution")
        _chart.series.addObject(sales)
        
        _chart.itemsSource = ChartPoint.generateRandomPoints(500)
        _chart.bindingX = "x"
        _chart.chartType = XuniChartType.Scatter
        _chart.zoomMode = XuniZoomMode.XY
        _chart.isAnimated = false
        _chart.header = NSLocalizedString("Drag to scroll/Pinch to zoom", comment: "")
        _chart.headerFont = UIFont.systemFontOfSize(14)
        _chart.headerTextAlignment = XuniHorizontalAlignment.Center
        _chart.palette = XuniPalettes.superhero()
        _chart.axisY.format = "N2"

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
        _pickerView.frame = CGRectMake(self.view.bounds.size.width / 3, 44, self.view.bounds.size.width / 2, 162)
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

