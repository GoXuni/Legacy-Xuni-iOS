//
//  DisplayingValuesController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class DisplayingValuesController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var linearGauge = XuniLinearGauge()
    var radialGauge = XuniRadialGauge()
    var pickerView = UIPickerView()
    var showTextLabel = UILabel()
    var stepper = UIStepper()
    var _title = UILabel()
    var _pickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _pickerData = ["All", "MinMax", "Value", "None"]
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        pickerView.hidden = false

        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Displaying Values"
        
        showTextLabel.textAlignment = NSTextAlignment.Left
        showTextLabel.textColor = UIColor.blackColor()
        showTextLabel.text = "Show text"

        stepper.maximumValue = 1
        stepper.minimumValue = 0
        stepper.value = 0.25
        stepper.stepValue = 0.25
        stepper.addTarget(self, action: "stepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        
        linearGauge.showText = XuniShowText.All;
        linearGauge.thickness = 0.6;
        linearGauge.min = 0
        linearGauge.max = 1
        linearGauge.value = 0.25
        linearGauge.loadAnimation.duration = 2;
        linearGauge.updateAnimation.duration = 0.5;
        linearGauge.format = "P0"
        
        radialGauge.showText = XuniShowText.All
        radialGauge.thickness = 0.6;
        radialGauge.min = 0;
        radialGauge.max = 1;
        radialGauge.value = 0.25;
        radialGauge.loadAnimation.duration = 2;
        radialGauge.updateAnimation.duration = 0.5;
        radialGauge.format = "P0";

        self.view.addSubview(linearGauge)
        self.view.addSubview(radialGauge)
        self.view.addSubview(pickerView)
        self.view.addSubview(showTextLabel)
        self.view.addSubview(stepper)
        self.view.addSubview(_title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var r1 = XuniRect(left: 0, top: 250, width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
        var r2 = XuniRect(left: 0, top: Double(100 + (self.view.bounds.size.height/2)), width: Double(self.view.bounds.size.width), height: Double((self.view.bounds.size.height/2) - 100))
        
        linearGauge.frame = CGRectMake(0, 250, self.view.bounds.size.width, self.view.bounds.size.height/8)
        linearGauge.rectGauge = r1
        radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, (self.view.bounds.size.height/2) - 100)
        radialGauge.rectGauge = r2
        showTextLabel.frame = CGRectMake(5, 110, 110, 50)
        pickerView.frame = CGRectMake(self.view.bounds.size.width - 120, 60, 100, 162)
        stepper.frame = CGRectMake(self.view.bounds.size.width/2 - 25, 200, 50, 50)
        _title.frame = CGRectMake(0, 45, self.view.bounds.size.width, 100)
        linearGauge.setNeedsDisplay()
        radialGauge.setNeedsDisplay()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0){
            linearGauge.showText = XuniShowText.All
            radialGauge.showText = XuniShowText.All
        }
        else if(row == 1){
            linearGauge.showText = XuniShowText.MinMax
            radialGauge.showText = XuniShowText.MinMax
        }
        else if(row == 2){
            linearGauge.showText = XuniShowText.Value
            radialGauge.showText = XuniShowText.Value
        }
        else if(row == 3){
            linearGauge.showText = XuniShowText.None
            radialGauge.showText = XuniShowText.None
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return _pickerData.objectAtIndex(row) as! String
    }
    func stepperClicked(sender: UIStepper) {
        
        linearGauge.value = stepper.value
        radialGauge.value = stepper.value
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
