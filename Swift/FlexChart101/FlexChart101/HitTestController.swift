//
//  HitTestController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class HitTestController: UIViewController, FlexChartDelegate {
    
    var _chart = FlexChart()
    var _chartElementLabel = UILabel()
    var _seriesLabel = UILabel()
    var _pointIndexLabel = UILabel()
    var _xyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Hit Test", comment: "")
        
        // Do any additional setup after loading the view.
        _chartElementLabel.text = " Chart element"
        _seriesLabel.text = " Series"
        _pointIndexLabel.text = " Point Index"
        _xyLabel.text = " X Y Values"
        
        let seriesCosX = XuniSeries(forChart: _chart, binding: "y, y", name: "cos(x)")
        let seriesSinX = XuniSeries(forChart: _chart, binding: "y, y", name: "sin(x)")
        
        seriesCosX.itemsSource = HitTestData.cosData()
        seriesSinX.itemsSource = HitTestData.sinData()
        
        _chart.series.addObject(seriesCosX)
        _chart.series.addObject(seriesSinX)
        
        _chart.bindingX = "x"
        _chart.delegate = self
        _chart.chartType = XuniChartType.LineSymbols
        _chart.axisY.format = "F"
        _chart.header = "Trigonometric Functions"
        _chart.footer = "Cartesian coordinates"
        
        self.view.addSubview(_chart)
        self.view.addSubview(_chartElementLabel)
        self.view.addSubview(_seriesLabel)
        self.view.addSubview(_pointIndexLabel)
        self.view.addSubview(_xyLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _chart.frame = CGRectMake(0, self.view.bounds.size.height / 8, self.view.bounds.size.width, self.view.bounds.size.height * 5 / 8)
        _seriesLabel.frame = CGRectMake(0, self.view.bounds.size.height * 13 / 16, self.view.bounds.size.width, self.view.bounds.size.height / 16)
        _pointIndexLabel.frame = CGRectMake(0, self.view.bounds.size.height * 14 / 16, self.view.bounds.size.width, self.view.bounds.size.height / 16)
        _xyLabel.frame = CGRectMake(0, self.view.bounds.size.height * 15 / 16, self.view.bounds.size.width, self.view.bounds.size.height / 16)
        _chartElementLabel.frame = CGRectMake(0, self.view.bounds.size.height * 6 / 8, self.view.bounds.size.width, self.view.bounds.size.height / 16)
    }
    
    func tapped(sender: XuniView!, point: XuniPoint!) -> Bool {
        let hitTest = _chart.hitTest(point)
        var seriesName = "";
        if (hitTest.dataPoint.seriesIndex >= 0 && hitTest.dataPoint.seriesIndex < Int32(_chart.series.count)) {
            seriesName = hitTest.dataPoint.seriesName;
        }
        
        _pointIndexLabel.text = " Point Index: " + String(hitTest.dataPoint.pointIndex);
        _xyLabel.text = " X:" + String(format: "%@", hitTest.dataPoint.valueX ?? "0") + " Y:" + String(format: "%1.2f", hitTest.dataPoint.value)
        _seriesLabel.text = " Series: " + seriesName
        _chartElementLabel.text = " Chart element: " + getChartTypeString(hitTest.chartElement)
        
        return false;
    }
    
    func getChartTypeString(chartElement: XuniChartElement) -> String {
        switch (chartElement) {
            case XuniChartElement.PlotArea:
                return "PlotArea"
            case XuniChartElement.AxisX:
                return "AxisX"
            case XuniChartElement.AxisY:
                return "AxisY"
            case XuniChartElement.ChartArea:
                return "ChartArea"
            case XuniChartElement.Legend:
                return "Legend"
            case XuniChartElement.Header:
                return "Header"
            case XuniChartElement.Footer:
                return "Footer"
            case XuniChartElement.None:
                return "None"
            default:
                return "Invalid Type"
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
