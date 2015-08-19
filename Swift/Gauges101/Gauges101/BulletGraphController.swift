//
//  BulletGraphController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class BulletGraphController: UIViewController {

    var bulletGraph = XuniBulletGraph()
    var goodStepper = UIStepper()
    var badStepper = UIStepper()
    var targetStepper = UIStepper()
    var _title = UILabel()
    var goodLabel = UILabel()
    var badLabel = UILabel()
    var targetLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        bulletGraph.isReadOnly = false
        bulletGraph.showText = XuniShowText.None
        bulletGraph.thickness = 0.6;
        bulletGraph.min = 0
        bulletGraph.max = 100
        bulletGraph.bad = 45
        bulletGraph.good = 80
        bulletGraph.target = 90
        bulletGraph.value = 25
        bulletGraph.pointer.thickness = 0.5
        bulletGraph.loadAnimation.duration = 2
        bulletGraph.updateAnimation.duration = 0.5

        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Bullet Graph"

        badStepper.maximumValue = 100
        badStepper.minimumValue = 0
        badStepper.value = 45
        badStepper.stepValue = 5;
        badStepper.addTarget(self, action: "badStepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        
        badLabel.textAlignment = NSTextAlignment.Left
        badLabel.textColor = UIColor.blackColor()
        badLabel.text = "Bad " + String(stringInterpolationSegment: badStepper.value);
        
        goodStepper.maximumValue = 100
        goodStepper.minimumValue = 0
        goodStepper.value = 80
        goodStepper.stepValue = 5;
        goodStepper.addTarget(self, action: "goodStepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        
        goodLabel.textAlignment = NSTextAlignment.Left
        goodLabel.textColor = UIColor.blackColor()
        goodLabel.text = "Good " + String(stringInterpolationSegment: goodStepper.value);
        
        targetStepper.maximumValue = 100;
        targetStepper.minimumValue = 0;
        targetStepper.value = 90;
        targetStepper.stepValue = 5;
        targetStepper.addTarget(self, action: "targetStepperClicked:", forControlEvents: UIControlEvents.ValueChanged)
        
        targetLabel.textAlignment = NSTextAlignment.Left
        targetLabel.textColor = UIColor.blackColor()
        targetLabel.text = "Target " + String(stringInterpolationSegment: targetStepper.value);
        
        self.view.addSubview(bulletGraph)
        self.view.addSubview(_title)
        self.view.addSubview(goodStepper)
        self.view.addSubview(badStepper)
        self.view.addSubview(targetStepper)
        self.view.addSubview(goodLabel)
        self.view.addSubview(badLabel)
        self.view.addSubview(targetLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var r1 = XuniRect(left: 0, top: Double(200 + (self.view.bounds.size.height/4)), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/6))
        
        bulletGraph.frame = CGRectMake(0, 200 + (self.view.bounds.size.height/4), self.view.bounds.size.width, self.view.bounds.size.height/6)
        bulletGraph.rectGauge = r1
        goodLabel.frame = CGRectMake(0, 170, 200, 50)
        badLabel.frame = CGRectMake(0, 120, 200, 50)
        targetLabel.frame = CGRectMake(0, 220, 200, 50)
        goodStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 170, 50, 50)
        badStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 120, 50, 50)
        targetStepper.frame = CGRectMake(self.view.bounds.size.width - 100, 220, 50, 50)
        _title.frame = CGRectMake(0, 45, self.view.bounds.size.width, 100)
        bulletGraph.setNeedsDisplay()
    }
    
    func badStepperClicked(sender: UIStepper) {
        bulletGraph.bad = badStepper.value
        badLabel.text = "Bad " + String(stringInterpolationSegment: badStepper.value);
    }
    func goodStepperClicked(sender: UIStepper) {
        bulletGraph.good = goodStepper.value
        goodLabel.text = "Good " + String(stringInterpolationSegment: goodStepper.value);
    }
    func targetStepperClicked(sender: UIStepper) {
        bulletGraph.target = targetStepper.value
        targetLabel.text = "Target " + String(stringInterpolationSegment: targetStepper.value);
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
