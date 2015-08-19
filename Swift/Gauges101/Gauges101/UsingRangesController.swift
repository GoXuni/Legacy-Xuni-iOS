//
//  UsingRangesController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class UsingRangesController: UIViewController {
    var radialGauge = XuniRadialGauge()
    var linearGauge = XuniLinearGauge()
    var stepper = UIStepper()
    var _title = UILabel()
    var rangeSwitch = UISwitch()
    var showRangesLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var min = 0.0
        var max = 100.0
        var val = 25.0
        
        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Using Ranges"
    
        linearGauge.showText = XuniShowText.None
        linearGauge.thickness = 0.6
        linearGauge.min = min
        linearGauge.max = max
        linearGauge.value = val
        linearGauge.loadAnimation.duration = 2
        linearGauge.updateAnimation.duration = 0.5
        linearGauge.showRanges = false
        
        radialGauge.showText = XuniShowText.None
        radialGauge.thickness = 0.6
        radialGauge.min = min
        radialGauge.max = max
        radialGauge.value = val
        radialGauge.loadAnimation.duration = 2
        radialGauge.updateAnimation.duration = 0.5
        radialGauge.showRanges = false
        
        var lower = XuniGaugeRange(gauge: linearGauge)
        lower.min = 0
        lower.max = 40
        lower.color = UIColor(red: CGFloat(0.133), green: CGFloat(0.694), blue: CGFloat(0.298), alpha: CGFloat(1))
        var middle = XuniGaugeRange(gauge: linearGauge)
        middle.min = 40
        middle.max = 80
        middle.color = UIColor(red: CGFloat(1), green: CGFloat(0.502), blue: CGFloat(0.502), alpha: CGFloat(1))
        var upper = XuniGaugeRange(gauge: linearGauge)
        upper.min = 80;
        upper.max = 100;
        upper.color = UIColor(red: CGFloat(0), green: CGFloat(0.635), blue: CGFloat(0.91), alpha: CGFloat(1))
        
        linearGauge.ranges.addObject(lower)
        linearGauge.ranges.addObject(middle)
        linearGauge.ranges.addObject(upper)
        radialGauge.ranges.addObject(lower)
        radialGauge.ranges.addObject(middle)
        radialGauge.ranges.addObject(upper)
        
        showRangesLabel.textAlignment = NSTextAlignment.Left
        showRangesLabel.textColor = UIColor.blackColor()
        showRangesLabel.text = "Show ranges"
        
        stepper.maximumValue = max
        stepper.minimumValue = min
        stepper.value = val
        stepper.stepValue = 25
        stepper.addTarget(self, action: "stepperClicked:", forControlEvents: UIControlEvents.ValueChanged)

        rangeSwitch.addTarget(self, action: "switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(radialGauge)
        self.view.addSubview(linearGauge)
        self.view.addSubview(stepper)
        self.view.addSubview(_title)
        self.view.addSubview(rangeSwitch)
        self.view.addSubview(showRangesLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var r1 = XuniRect(left: 0, top: 250, width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
        var r2 = XuniRect(left: 0, top: Double(100 + (self.view.bounds.size.height/2)), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/2))
        
        linearGauge.frame = CGRectMake(0, 250, self.view.bounds.size.width, self.view.bounds.size.height/8)
        linearGauge.rectGauge = r1
        linearGauge.setNeedsDisplay()
        
        radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/2)
        radialGauge.rectGauge = r2
        radialGauge.setNeedsDisplay()
        
        _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100)
        stepper.frame = CGRectMake(self.view.bounds.size.width/2 - 25, 170, 50, 50)
        showRangesLabel.frame = CGRectMake(5, 110, 200, 50);
        rangeSwitch.frame = CGRectMake(self.view.bounds.size.width - 75, 120, 50, 50);

    }
    
    func stepperClicked(sender: UIStepper) {
        linearGauge.value = stepper.value
        radialGauge.value = stepper.value
    }
    func switchChanged(switchState: UISwitch) {
        if (switchState.on) {
            linearGauge.showRanges = true
            radialGauge.showRanges = true
        }
        else
        {
            linearGauge.showRanges = false
            radialGauge.showRanges = false
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
