//
//  DataLabelController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class DataLabelController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _positionPickerView = UIPickerView()
    var _positionPickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Data Labels"
        
        // Do any additional setup after loading the view.
        _positionPickerData = ["None", "Left", "Top", "Right", "Bottom", "Center"]
        _positionPickerView.delegate = self
        _positionPickerView.showsSelectionIndicator = true
        _positionPickerView.hidden = false
        _positionPickerView.tag = 2
        _positionPickerView.selectRow(1, inComponent: 0, animated: false)
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        
        _chart.series.addObject(sales)
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.chartType = XuniChartType.Bar;
        _chart.isAnimated = false;
        _chart.tooltip.isVisible = false;
        _chart.axisX.majorGridVisible = true;
        _chart.axisY.labelsVisible = false;
        _chart.axisY.majorGridVisible = false;
        _chart.axisY.minorGridVisible = false;
        _chart.axisY.majorTickWidth = 0;
        _chart.palette = XuniPalettes.organic();
        
        _chart.dataLabel.content = "{x} {y}"
        _chart.dataLabel.dataLabelFormat = "F2"
        _chart.dataLabel.position = FlexChartDataLabelPosition.Left
        _chart.dataLabel.dataLabelFontColor = UIColor.redColor()
        _chart.dataLabel.dataLabelBackgroundColor = UIColor.whiteColor()
        _chart.dataLabel.dataLabelBorderColor = UIColor.blueColor()
        _chart.dataLabel.dataLabelBorderWidth = 1
        _chart.dataLabel.dataLabelFont = UIFont.systemFontOfSize(15)
        
        self.view.addSubview(_chart)
        self.view.addSubview(_positionPickerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _positionPickerView.frame = CGRectMake(0, 44, self.view.bounds.size.width, 162)
        _chart.frame = CGRectMake(0, 206, self.view.bounds.size.width, self.view.bounds.size.height - 206)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2){
            return _positionPickerData.count
        }
        
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 2) {
            if (row == 0) {
                _chart.dataLabel.position = FlexChartDataLabelPosition.None
            }
            else if (row == 1){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Left
            }
            else if (row == 2){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Top
            }
            else if (row == 3){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Right
            }
            else if (row == 4){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Bottom
            }
            else if (row == 5){
                _chart.dataLabel.position = FlexChartDataLabelPosition.Center
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 2){
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
