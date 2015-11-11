//
//  LegendAndTitlesController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexPieKit

class LegendAndTitlesController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var _pickerView = UIPickerView()
    var _pieChart = FlexPie()
    var _pickerData = NSMutableArray()
    var _headerLabel = UILabel()
    var _footerLabel = UILabel()
    var _legendLabel = UILabel()
    var _headerField = UITextField()
    var _footerField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _pickerData = ["None", "Left", "Top", "Right", "Bottom"]
        
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
        _headerLabel.text = "Header"
        _footerLabel.text = "Footer"
        _legendLabel.text = "Legend Position"
        
        _headerField.delegate = self
        _headerField.text = "Fruit By Value"
        _headerField.returnKeyType = UIReturnKeyType.Done
        _headerField.keyboardType = UIKeyboardType.Default
        _headerField.backgroundColor = UIColor.lightGrayColor()
        
        _footerField.delegate = self;
        _footerField.text = "4 GrapeCity, inc."
        _footerField.returnKeyType = UIReturnKeyType.Done
        _footerField.keyboardType = UIKeyboardType.Default
        _footerField.backgroundColor = UIColor.lightGrayColor()
        
        var pieData = NSMutableArray()
        pieData = PieChartData.demoData()
        _pieChart.binding = "value"
        _pieChart.bindingName = "name"
        _pieChart.itemsSource = pieData
        _pieChart.tooltip.isVisible = true
        _pieChart.header = _headerField.text
        _pieChart.sizeToFit()
        self.view.addSubview(_footerField)
        self.view.addSubview(_footerLabel)
        self.view.addSubview(_headerField)
        self.view.addSubview(_headerLabel)
        self.view.addSubview(_legendLabel)
        self.view.addSubview(_pieChart)
        self.view.addSubview(_pickerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _headerField.frame = CGRectMake(0, 115, self.view.bounds.size.width/2 - 10, 50)
        _footerField.frame = CGRectMake(self.view.bounds.size.width/2, 115, self.view.bounds.size.width/2 - 10, 50)
        _pieChart.frame = CGRectMake(self.view.bounds.size.width/4, 215, self.view.bounds.size.width*3/4, self.view.bounds.size.height - 215)
        _headerLabel.frame = CGRectMake(0, 65, self.view.bounds.size.width/2 , 50)
        _footerLabel.frame = CGRectMake(self.view.bounds.size.width/2, 65, self.view.bounds.size.width/2, 50)
        _legendLabel.frame = CGRectMake(0, 165, self.view.bounds.size.width/2, 50)
        _pickerView.frame = CGRectMake(0, 215, self.view.bounds.size.width/4, 162)
        
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
            _pieChart.legend.position = XuniChartLegendPosition.None
        case 1:
             _pieChart.legend.position = XuniChartLegendPosition.Left
        case 2:
             _pieChart.legend.position = XuniChartLegendPosition.Top
        case 3:
             _pieChart.legend.position = XuniChartLegendPosition.Right
        case 4:
             _pieChart.legend.position = XuniChartLegendPosition.Bottom
        default:
            break;
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return _pickerData.objectAtIndex(row) as! String
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true;
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        _pieChart.header = _headerField.text
        _pieChart.footer = _footerField.text
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
