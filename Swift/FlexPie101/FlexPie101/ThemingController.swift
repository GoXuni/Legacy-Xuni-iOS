//
//  ThemingController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexPieKit

class ThemingController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var _pickerView = UIPickerView()
    var _pieChart = FlexPie()
    var _pickerData = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _pickerData = ["Standard", "Cocoa", "Coral", "Dark", "HighContrast", "Light", "Midnight", "Minimal", "Modern", "Organic", "Slate", "Zen", "Cyborg", "Superhero", "Flatly", "Darkly", "Cerulean"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
        var pieData = NSMutableArray()
        pieData = PieChartData.demoData()
        _pieChart.binding = "value"
        _pieChart.bindingName = "name"
        _pieChart.itemsSource = pieData
        _pieChart.tooltip.isVisible = true
        self.view.addSubview(_pieChart)
        self.view.addSubview(_pickerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _pieChart.frame = CGRectMake(0, 227, self.view.bounds.size.width, (self.view.bounds.size.height-227))
        _pickerView.frame = CGRectMake(self.view.bounds.size.width/4, 65, self.view.bounds.size.width/2, 162)
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
            _pieChart.palette = XuniPalettes.standard()
        case 1:
            _pieChart.palette = XuniPalettes.cocoa()
        case 2:
            _pieChart.palette = XuniPalettes.coral()
        case 3:
            _pieChart.palette = XuniPalettes.dark()
        case 4:
            _pieChart.palette = XuniPalettes.highcontrast()
        case 5:
            _pieChart.palette = XuniPalettes.light()
        case 6:
            _pieChart.palette = XuniPalettes.midnight()
        case 7:
            _pieChart.palette = XuniPalettes.minimal()
        case 8:
            _pieChart.palette = XuniPalettes.modern()
        case 9:
            _pieChart.palette = XuniPalettes.organic()
        case 10:
            _pieChart.palette = XuniPalettes.slate()
        case 11:
            _pieChart.palette = XuniPalettes.zen()
        case 12:
            _pieChart.palette = XuniPalettes.cyborg()
        case 13:
            _pieChart.palette = XuniPalettes.superhero()
        case 14:
            _pieChart.palette = XuniPalettes.flatly()
        case 15:
            _pieChart.palette = XuniPalettes.darkly()
        case 16:
            _pieChart.palette = XuniPalettes.cerulean()
        default:
            break;
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
