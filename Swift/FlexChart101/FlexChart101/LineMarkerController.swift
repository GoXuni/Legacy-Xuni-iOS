//
//  LineMarkerController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class LineMarkerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var _chart = FlexChart()
    var _interactionPickerView = UIPickerView()
    var _interactionPickerData = NSMutableArray()
    var _verticalPositionPickerView = UIPickerView()
    var _verticalPositionPickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Line Marker", comment: "")
        
        // Do any additional setup after loading the view.
        _interactionPickerData = ["None", "Move", "Drag"]
        _interactionPickerView.delegate = self
        _interactionPickerView.showsSelectionIndicator = true
        _interactionPickerView.hidden = false
        _interactionPickerView.tag = 2
        _interactionPickerView.selectRow(1, inComponent: 0, animated: false)
        
        _verticalPositionPickerData = ["NaN", "0", "0.25", "0.5", "0.75", "1"]
        _verticalPositionPickerView.delegate = self
        _verticalPositionPickerView.showsSelectionIndicator = true
        _verticalPositionPickerView.hidden = false
        _verticalPositionPickerView.tag = 3
        _verticalPositionPickerView.selectRow(1, inComponent: 0, animated: false)
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.chartType = XuniChartType.Line;
        
        // Implement Chart Line Marker.
        let view = MyMarkerView(lineMarker: _chart.lineMarker)
        view.markerRender = MyChartMarkerRender(view: view)
        _chart.lineMarker.content = view
        _chart.lineMarker.isVisible = true
        _chart.lineMarker.alignment = XuniChartMarkerAlignment.BottomRight
        _chart.lineMarker.lines = XuniChartMarkerLines.Vertical
        _chart.lineMarker.interaction = XuniChartMarkerInteraction.Move
        _chart.lineMarker.dragContent = true
        _chart.lineMarker.seriesIndex = -1
        _chart.lineMarker.verticalLineColor = UIColor.grayColor()
        _chart.lineMarker.verticalPosition = 0
        _chart.addSubview(view)
        
        self.view.addSubview(_chart)
        self.view.addSubview(_interactionPickerView)
        self.view.addSubview(_verticalPositionPickerView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let halfWidth = self.view.bounds.size.width / 2;
        _interactionPickerView.frame = CGRectMake(0, 30, halfWidth, 162)
        _verticalPositionPickerView.frame = CGRectMake(halfWidth, 30, halfWidth, 162);
        _chart.frame = CGRectMake(0, 162, self.view.bounds.size.width, self.view.bounds.size.height - 162)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 2){
            return _interactionPickerData.count
        }
        else if(pickerView.tag == 3){
            return _verticalPositionPickerData.count
        }
        else {
            return 0;
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 2){
            if (row == 0) {
                _chart.lineMarker.interaction = XuniChartMarkerInteraction.None;
            }
            else if (row == 1){
                _chart.lineMarker.interaction = XuniChartMarkerInteraction.Move;
            }
            else if (row == 2){
                _chart.lineMarker.interaction = XuniChartMarkerInteraction.Drag;
            }
        }
        else if(pickerView.tag == 3){
            if (row == 0) {
                _chart.lineMarker.verticalPosition = Double.NaN;
            }
            else if (row == 1){
                _chart.lineMarker.verticalPosition = 0;
            }
            else if (row == 2){
                _chart.lineMarker.verticalPosition = 0.25;
            }
            else if (row == 3){
                _chart.lineMarker.verticalPosition = 0.5;
            }
            else if (row == 4){
                _chart.lineMarker.verticalPosition = 0.75;
            }
            else if (row == 5){
                _chart.lineMarker.verticalPosition = 1;
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 2){
            return _interactionPickerData.objectAtIndex(row) as! String
        }
        else if(pickerView.tag == 3){
            return _verticalPositionPickerData.objectAtIndex(row) as! String
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

class MyMarkerView : XuniChartMarkerBaseView {
    var myLineMarker : XuniChartLineMarker
    var content : UILabel

     override init(lineMarker: XuniChartLineMarker) {
        self.myLineMarker = lineMarker
        self.content = UILabel()
        super.init(lineMarker: lineMarker)
        
        self.backgroundColor = UIColor(white: 0.8, alpha: 0.6)
        self.frame = CGRectMake(0, 0, 110, 60);
        self.myLineMarker = lineMarker
        self.content.frame = CGRectMake(5, 5, 100, 50)
        self.content.backgroundColor = UIColor.clearColor()
        self.content.font = UIFont.systemFontOfSize(10.0)
        self.addSubview(self.content)
    }

     required init(coder aDecoder: NSCoder) {
        self.myLineMarker = XuniChartLineMarker()
        self.content = UILabel()
        super.init(coder: aDecoder)!
     }
    
    override init(frame: CGRect) {
        self.myLineMarker = XuniChartLineMarker()
        self.content = UILabel()
        super.init(frame: frame)
    }
}

class MyChartMarkerRender : NSObject, IXuniChartMarkerRender {
    var myView : XuniChartMarkerBaseView
    
    init(view: XuniChartMarkerBaseView) {
        self.myView = view
    }
    
    @objc func renderMarker() {
        var view: MyMarkerView = self.myView as! MyMarkerView
        var data = view.myLineMarker.dataPoints
        
        if (data != nil && data.count > 0) {
            var point: XuniChartDataPoint = data[0] as! XuniChartDataPoint
            var str: String = String(format: "%@ \n", point.valueX)
            
            for var i = 0; i < data.count - 1; i++ {
                point = data[i] as! XuniChartDataPoint;
                str += String(format: "%@ : %.0f \n", point.seriesName, point.value)
            }
            point = data[data.count - 1] as! XuniChartDataPoint;
            str += String(format: "%@ : %.0f", point.seriesName, point.value)
            
            view.content.text = str;
            view.content.numberOfLines = 4;
        }
    }
}
