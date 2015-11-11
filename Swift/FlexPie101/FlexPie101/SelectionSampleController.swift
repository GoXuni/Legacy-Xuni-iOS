//
//  SelectionSampleController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexPieKit

class SelectionSampleController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var _pickerView = UIPickerView()
    var _pieChart = FlexPie()
    var _pickerData = NSMutableArray()
    var offsetLabel = UILabel()
    var positionLabel = UILabel()
    var isAnimatedLabel = UILabel()
    var stepper = UIStepper()
    var isAnimatedSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        _pickerData = ["None", "Left", "Top", "Right", "Bottom"]
        _pickerView.delegate = self
        _pickerView.showsSelectionIndicator = true
        _pickerView.hidden = false
        
        isAnimatedSwitch.addTarget(self, action:"switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        stepper.maximumValue = 0.5
        stepper.minimumValue = 0.0
        stepper.value = 0.2
        stepper.stepValue = 0.1
        stepper.addTarget(self, action:"stepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        
        offsetLabel.text = "Selected Item offset " + String(stringInterpolationSegment: stepper.value)
        
        positionLabel.text = "Position"
        
        isAnimatedLabel.text = "IsAnimated?"
        
        var pieData = NSMutableArray()
        pieData = PieChartData.demoData()
        _pieChart.binding = "value"
        _pieChart.bindingName = "name"
        _pieChart.itemsSource = pieData
        _pieChart.tooltip.isVisible = true
        
        self.view.addSubview(_pieChart)
        self.view.addSubview(_pickerView)
        self.view.addSubview(isAnimatedSwitch)
        self.view.addSubview(stepper)
        self.view.addSubview(offsetLabel)
        self.view.addSubview(positionLabel)
        self.view.addSubview(isAnimatedLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        offsetLabel.frame = CGRectMake(0, 65, self.view.bounds.size.width/2, 50)
        offsetLabel.sizeToFit()
        positionLabel.frame = CGRectMake(0, 115, self.view.bounds.size.width/4, 50)
        positionLabel.sizeToFit()
        isAnimatedLabel.frame = CGRectMake(self.view.bounds.size.width/2, 115, self.view.bounds.size.width/4, 50)
        isAnimatedLabel.sizeToFit()
        stepper.frame = CGRectMake(self.view.bounds.size.width * 5/8, 65, self.view.bounds.size.width/4, 50)
        _pickerView.frame = CGRectMake(0, 165, self.view.bounds.size.width/4, 162)
        isAnimatedSwitch.frame = CGRectMake((self.view.bounds.size.width * 3/4) + 5, 115, 50, 50)
        _pieChart.frame = CGRectMake(self.view.bounds.size.width/4, 165, self.view.bounds.size.width*3/4, self.view.bounds.size.height-165)

    }
    
    func switchChanged(switchState: UISwitch) {
        if (switchState.on) {
            _pieChart.isAnimated = true
        }
        else
        {
            _pieChart.isAnimated = false
        }
    }
    
    func stepperClicked(sender: UIStepper) {
        _pieChart.selectedItemOffset = stepper.value
        offsetLabel.text = "Selected Item offset " + String(stringInterpolationSegment: stepper.value)
        offsetLabel.sizeToFit()
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
            _pieChart.selectedItemPosition = XuniPosition.None
        case 1:
            _pieChart.selectedItemPosition = XuniPosition.Left
        case 2:
            _pieChart.selectedItemPosition = XuniPosition.Top
        case 3:
            _pieChart.selectedItemPosition = XuniPosition.Right
        case 4:
            _pieChart.selectedItemPosition = XuniPosition.Bottom
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

