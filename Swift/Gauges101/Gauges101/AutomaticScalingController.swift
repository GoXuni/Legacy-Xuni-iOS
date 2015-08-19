//
//  AutomaticScalingController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class AutomaticScalingController: UIViewController {
    var radialGauge = XuniRadialGauge()
    var startAngleStepper = UIStepper()
    var sweepAngleStepper = UIStepper()
    var _title = UILabel()
    var startLabel = UILabel()
    var sweepLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var min = 0.0
        var max = 200.0
        var val = 25.0
        
        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Custom Animations"
        
        radialGauge.showText = XuniShowText.All
        radialGauge.min = min
        radialGauge.max = max
        radialGauge.value = val
        radialGauge.loadAnimation.duration = 2
        radialGauge.updateAnimation.duration = 2
        
        startAngleStepper.maximumValue = 360
        startAngleStepper.minimumValue = 0
        startAngleStepper.value = 0
        startAngleStepper.stepValue = 45
        
        sweepAngleStepper.maximumValue = 360
        sweepAngleStepper.minimumValue = 45
        sweepAngleStepper.value = 180
        sweepAngleStepper.stepValue = 45
        
        startAngleStepper.addTarget(self, action: "startAngleStepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        sweepAngleStepper.addTarget(self, action: "sweepAngleStepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        
        startLabel.text = "Start Angle " + String(stringInterpolationSegment: startAngleStepper.value)
        sweepLabel.text = "Sweep Angle " + String(stringInterpolationSegment: sweepAngleStepper.value);
        
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "generateRandomNumber", userInfo: nil, repeats: true)
        self.view.addSubview(radialGauge)
        self.view.addSubview(startAngleStepper)
        self.view.addSubview(sweepAngleStepper)
        self.view.addSubview(startLabel)
        self.view.addSubview(sweepLabel)
        self.view.addSubview(_title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var r1 = XuniRect(left: 0, top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/2))
        
        radialGauge.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)
        radialGauge.rectGauge = r1

        _title.frame = CGRectMake(0, 45, self.view.bounds.size.width, 100)
        startAngleStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 120, 50, 50)
        sweepAngleStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 170, 50, 50)
        startLabel.frame = CGRectMake(0, 110, 200, 50)
        sweepLabel.frame = CGRectMake(0, 160, 200, 50)
        
        radialGauge.setNeedsDisplay()
    }
    
    func generateRandomNumber(){
        radialGauge.value = Double(arc4random()%201)
    }
    func startAngleStepperClicked(sender: UIStepper) {
        radialGauge.startAngle = startAngleStepper.value
        startLabel.text = "Start Angle " + String(stringInterpolationSegment: startAngleStepper.value)
    }
    func sweepAngleStepperClicked(sender: UIStepper) {
        radialGauge.sweepAngle = sweepAngleStepper.value
        sweepLabel.text = "Sweep Angle " + String(stringInterpolationSegment: sweepAngleStepper.value)
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
