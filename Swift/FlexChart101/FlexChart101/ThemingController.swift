//
//  ThemingController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class ThemingController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var _chart = FlexChart()
    var _pickerView = UIPickerView()
    var _pickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _pickerData = ["Standard", "Cocoa", "Coral", "Dark", "HighContrast", "Light", "Midnight", "Minimal", "Modern", "Organic", "Slate", "Zen", "Cyborg", "Superhero", "Flatly", "Darkly", "Cerulean"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
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
        _chart.tooltip.isVisible = true
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
            _chart.palette = XuniPalettes.standard()
        case 1:
            _chart.palette = XuniPalettes.cocoa()
        case 2:
            _chart.palette = XuniPalettes.coral()
        case 3:
            _chart.palette = XuniPalettes.dark()
        case 4:
            _chart.palette = XuniPalettes.highcontrast()
        case 5:
            _chart.palette = XuniPalettes.light()
        case 6:
            _chart.palette = XuniPalettes.midnight()
        case 7:
            _chart.palette = XuniPalettes.minimal()
        case 8:
            _chart.palette = XuniPalettes.modern()
        case 9:
            _chart.palette = XuniPalettes.organic()
        case 10:
            _chart.palette = XuniPalettes.slate()
        case 11:
            _chart.palette = XuniPalettes.zen()
        case 12:
            _chart.palette = XuniPalettes.cyborg()
        case 13:
            _chart.palette = XuniPalettes.superhero()
        case 14:
            _chart.palette = XuniPalettes.flatly()
        case 15:
            _chart.palette = XuniPalettes.darkly()
        case 16:
            _chart.palette = XuniPalettes.cerulean()
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
