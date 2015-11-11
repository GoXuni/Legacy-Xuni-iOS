//
//  BasicFeaturesController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexPieKit

class BasicFeaturesController: UIViewController {
    
    var innerRadiusLabel = UILabel()
    var stepper = UIStepper()
    var offsetLabel = UILabel()
    var offsetSlider = UISlider()
    var startAngleLabel = UILabel()
    var startAngleSlider = UISlider()
    var reversedLabel = UILabel()
    var reversedSwitch = UISwitch()
    var pieChart = FlexPie()
    var pieData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        // Do any additional setup after loading the view.
        var pieData = NSMutableArray()
        pieData = PieChartData.demoData()
        pieChart.binding = "value"
        pieChart.bindingName = "name"
        pieChart.itemsSource = pieData
        
        stepper.maximumValue = 0.99
        stepper.minimumValue = 0.0
        stepper.value = 0.0
        stepper.stepValue = 0.1
        stepper.addTarget(self, action: "stepperClicked:", forControlEvents:UIControlEvents.ValueChanged)
        
        innerRadiusLabel.text = "Inner Radius " + String(stringInterpolationSegment: stepper.value)
        
        offsetLabel.text = "Offset"
        
        offsetSlider.addTarget(self, action:"offsetSliderChanged:", forControlEvents:UIControlEvents.ValueChanged)
        offsetSlider.minimumValue = 0.0
        offsetSlider.maximumValue = 1.0
        
        startAngleLabel.text = "Start Angle"
        
        startAngleSlider.addTarget(self, action:"startAngleSliderChanged:", forControlEvents:UIControlEvents.ValueChanged)
        startAngleSlider.minimumValue = 0.0
        startAngleSlider.maximumValue = 360.0
        
        reversedLabel.text = "Reversed?"
        reversedSwitch.addTarget(self, action:"switchChanged:", forControlEvents:UIControlEvents.ValueChanged)
        
        self.view.addSubview(innerRadiusLabel)
        self.view.addSubview(stepper)
        self.view.addSubview(offsetLabel)
        self.view.addSubview(offsetSlider)
        self.view.addSubview(startAngleLabel)
        self.view.addSubview(startAngleSlider)
        self.view.addSubview(reversedLabel)
        self.view.addSubview(reversedSwitch)
        self.view.addSubview(pieChart)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        innerRadiusLabel.frame = CGRectMake(5, 5, 100, 50)
        innerRadiusLabel.sizeToFit()
        stepper.frame = CGRectMake(self.view.bounds.size.width/2 - 25, 5, 50, 50)
        offsetLabel.frame = CGRectMake(5, self.view.bounds.size.height/8, 100, 50)
        offsetSlider.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/8, self.view.bounds.size.width/2 - 5, 50)
        startAngleLabel.frame = CGRectMake(5, self.view.bounds.size.height/4, 100, 50)
        startAngleSlider.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, self.view.bounds.size.width/2 - 5, 50)
        reversedLabel.frame = CGRectMake(5, self.view.bounds.size.height*3/8, 100, 50)
        reversedSwitch.frame = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height*3/8, 50, 50)
        pieChart.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)
        
    }
    
    func switchChanged(switchState: UISwitch) {
        if (switchState.on) {
            pieChart.reversed = true
        }
        else{
            pieChart.reversed = false
        }
    }
    
    func stepperClicked(sender: UIStepper) {
        pieChart.innerRadius = stepper.value
        innerRadiusLabel.text = "Inner Radius " + String(stringInterpolationSegment: stepper.value)
        innerRadiusLabel.sizeToFit()
    }
    func offsetSliderChanged(sender: UISlider){
        pieChart.offset = Double(sender.value)
    }
    func startAngleSliderChanged(sender: UISlider){
        pieChart.startAngle = Double(sender.value)
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
