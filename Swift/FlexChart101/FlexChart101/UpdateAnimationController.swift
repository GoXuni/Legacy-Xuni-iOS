//
//  UpdateAnimationController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class UpdateAnimationController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _chartTypePickerView = UIPickerView()
    var _chartTypePickerData = NSMutableArray()
    var _updatePositionPickerView = UIPickerView()
    var _updatePositionPickerData = NSMutableArray()
    var _addPointBtn = UIButton(type: UIButtonType.System)
    var _removePointBtn = UIButton(type: UIButtonType.System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Update Animation", comment: "")
        
        // Do any additional setup after loading the view.
        _chartTypePickerData = ["Column", "Area", "Line", "LineSymbols", "Spline", "SplineSymbols", "SplineArea", "Scatter"]
        _chartTypePickerView.delegate = self
        _chartTypePickerView.showsSelectionIndicator = true
        _chartTypePickerView.hidden = false
        _chartTypePickerView.tag = 2
        
        _updatePositionPickerData = ["Beginning", "Middle", "End"]
        _updatePositionPickerView.delegate = self
        _updatePositionPickerView.showsSelectionIndicator = true
        _updatePositionPickerView.hidden = false
        _updatePositionPickerView.tag = 3
        
        _addPointBtn.tag = 4
        _addPointBtn.setTitle(NSLocalizedString("Add Point", comment: ""), forState: UIControlState.Normal)
        _addPointBtn.addTarget(self, action: "addPointAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        _removePointBtn.tag = 5
        _removePointBtn.setTitle(NSLocalizedString("Remove Point", comment: ""), forState: UIControlState.Normal)
        _removePointBtn.addTarget(self, action: "removePointAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        let value = XuniSeries(forChart: _chart, binding: "value", name: "value")
        
        _chart.series.addObject(value)
        _chart.bindingX = "xValue"
        _chart.itemsSource = UpdateData.demoData()
        _chart.loadAnimation.animationMode = XuniAnimationMode.Point
        _chart.legend.position = XuniChartLegendPosition.None
        _chart.palette = XuniPalettes.cocoa()
        _chart.axisY.axisLineVisible = false
        _chart.axisY.majorTickWidth = 0
        
        self.view.addSubview(_chart)
        self.view.addSubview(_chartTypePickerView)
        self.view.addSubview(_updatePositionPickerView)
        self.view.addSubview(_addPointBtn)
        self.view.addSubview(_removePointBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _chartTypePickerView.frame = CGRectMake(0, 44, self.view.bounds.size.width / 2, 162)
        _updatePositionPickerView.frame = CGRectMake(self.view.bounds.size.width / 2, 44, self.view.bounds.size.width / 2, 162)
        _addPointBtn.frame = CGRectMake(20, 206, 120, 40)
        _removePointBtn.frame = CGRectMake(160, 206, 120, 40)
        _chart.frame = CGRectMake(0, 206 + 40, self.view.bounds.size.width, self.view.bounds.size.height - 206 - 40)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 2) {
            return _chartTypePickerData.count
        }
        else {
            return _updatePositionPickerData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 2) {
            if (row == 0) {
                _chart.chartType = XuniChartType.Column;
            }
            else if (row == 1) {
                _chart.chartType = XuniChartType.Area;
            }
            else if (row == 2) {
                _chart.chartType = XuniChartType.Line;
            }
            else if (row == 3) {
                _chart.chartType = XuniChartType.LineSymbols;
            }
            else if (row == 4) {
                _chart.chartType = XuniChartType.Spline;
            }
            else if (row == 5) {
                _chart.chartType = XuniChartType.SplineSymbols;
            }
            else if (row == 6) {
                _chart.chartType = XuniChartType.SplineArea;
            }
            else if (row == 7) {
                _chart.chartType = XuniChartType.Scatter;
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView.tag == 2) {
            return _chartTypePickerData.objectAtIndex(row) as! String
        }
        else if (pickerView.tag == 3) {
            return _updatePositionPickerData.objectAtIndex(row) as! String
        }
        else {
            return "error"
        }
    }
    
    func addPointAction() {
        var row = _updatePositionPickerView.selectedRowInComponent(0)
        var num = 65 + rand() % (90 - 65 + 1)
        var data = UpdateData(xValue: String(format: "%c", num), value: UpdateData.randomNumberBetween(10, max: 80))
        
        if row == 0 {
            _chart.collectionView.insertObject(data, atIndex: 0)
        }
        else if row == 1 {
            _chart.collectionView.insertObject(data, atIndex: UInt(_chart.collectionView.itemCount / 2))
        }
        else if row == 2 {
            _chart.collectionView.addObject(data)
        }

    }
    
    func removePointAction() {
        var row = _updatePositionPickerView.selectedRowInComponent(0)
        
        if row == 0 {
            _chart.collectionView.removeAt(0)
        }
        else if row == 1 {
            _chart.collectionView.removeAt(_chart.collectionView.itemCount / 2)
        }
        else if row == 2 {
            _chart.collectionView.removeAt(_chart.collectionView.itemCount - 1)
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

class UpdateData : NSObject {
    var xValue: String
    var value: Int
    
    init(xValue: String, value: Int) {
        self.xValue = xValue
        self.value = value
    }
    
    class func randomNumberBetween(min: Int, max: Int) -> Int {
        return (min + Int(rand()) % (max - min + 1));
    }
    
    class func demoData() -> NSMutableArray {
        var arrData = NSMutableArray()
        var num: Int
        var data: UpdateData
        
        for var i = 0; i < 8; i++ {
            num = 65 + Int(rand()) % (90 - 65 + 1)
            data = UpdateData(xValue: String(format: "%c", num), value: UpdateData.randomNumberBetween(i, max: (10 + i * i)))
            arrData.addObject(data)
        }
        
        return arrData
    }
}
