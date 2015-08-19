//
//  GettingStartedController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class GettingStartedController: UIViewController {
    var linearGauge = XuniLinearGauge()
    var bulletGraph = XuniBulletGraph()
    var radialGauge = XuniRadialGauge()
    var value = UILabel()
    var stepper = UIStepper()
    var _title = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Getting Started"
        
        stepper.maximumValue = 100
        stepper.minimumValue = 0
        stepper.value = 25
        stepper.stepValue = 25
        stepper.tag = 5
        stepper.addTarget(self, action: "stepperClicked:", forControlEvents: UIControlEvents.ValueChanged)

        linearGauge.tag = 1;
        linearGauge.showText = XuniShowText.None
        linearGauge.thickness = 0.6
        linearGauge.min = 0
        linearGauge.max = 100
        linearGauge.value = 25
        linearGauge.loadAnimation.duration = 2
        linearGauge.updateAnimation.duration = 0.5
        
        
        bulletGraph.tag = 2
        bulletGraph.showText = XuniShowText.None
        bulletGraph.thickness = 0.6
        bulletGraph.min = 0
        bulletGraph.max = 100
        bulletGraph.bad = 45
        bulletGraph.good = 80
        bulletGraph.target = 90
        bulletGraph.value = 25
        bulletGraph.pointer.thickness = 0.5
        bulletGraph.loadAnimation.duration = 2
        bulletGraph.updateAnimation.duration = 0.5
        
        
        radialGauge.tag = 3
        radialGauge.showText = XuniShowText.None
        radialGauge.thickness = 0.6
        radialGauge.min = 0
        radialGauge.max = 100
        radialGauge.value = 25
        radialGauge.loadAnimation.duration = 2
        radialGauge.updateAnimation.duration = 0.5
        
        
        value.tag = 4;
        value.textAlignment = NSTextAlignment.Left
        value.textColor = UIColor.blackColor()
        value.text = "Value " + String(stringInterpolationSegment: stepper.value);
        self.view.addSubview(linearGauge)
        self.view.addSubview(bulletGraph)
        self.view.addSubview(radialGauge)
        self.view.addSubview(value)
        self.view.addSubview(stepper)
        self.view.addSubview(_title)
    }
    
    func stepperClicked(sender: UIStepper) {
        
        linearGauge.value = stepper.value
        bulletGraph.value = stepper.value
        radialGauge.value = stepper.value
        value.text = "Value " + String(stringInterpolationSegment: stepper.value);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var r1 = XuniRect(left: 0, top: 150, width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
        var r2 = XuniRect(left: 0, top: Double(100 + (self.view.bounds.size.height/4)), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
        var r3 = XuniRect(left: 0, top: Double(100 + (self.view.bounds.size.height/2)), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/2))
        
        linearGauge.frame = CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height/8)
        linearGauge.rectGauge = r1
        bulletGraph.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/8)
        bulletGraph.rectGauge = r2
        radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/2)
        radialGauge.rectGauge = r3
        value.frame = CGRectMake(0, 110, 200, 50)
        stepper.frame = CGRectMake(self.view.bounds.size.width - 100, 120, 50, 50)
        _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100)
        linearGauge.setNeedsDisplay()
        radialGauge.setNeedsDisplay()
        bulletGraph.setNeedsDisplay()
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
