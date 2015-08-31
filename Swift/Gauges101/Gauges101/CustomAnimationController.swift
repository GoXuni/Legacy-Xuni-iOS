//
//  CustomAnimationController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class CustomAnimationController: UIViewController {
    
    var radialGauge = XuniRadialGauge()
    var linearGauge = XuniLinearGauge()
    var _title = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var min = 0.0
        var max = 100.0
        var val = 25.0
        
        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Custom Animations"
        
        radialGauge.showText = XuniShowText.All
        radialGauge.thickness = 0.6
        radialGauge.min = min
        radialGauge.max = max
        radialGauge.value = val
        radialGauge.loadAnimation.duration = 2
        radialGauge.updateAnimation.duration = 2
        radialGauge.pointer.thickness = 0.5

        linearGauge.showText = XuniShowText.None
        linearGauge.thickness = 0.6
        linearGauge.min = min
        linearGauge.max = max
        linearGauge.value = val
        linearGauge.loadAnimation.duration = 2
        linearGauge.updateAnimation.duration = 2
        linearGauge.pointer.thickness = 0.5
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "animateNextStep", userInfo: nil, repeats: true)
        
        self.view.addSubview(_title)
        self.view.addSubview(linearGauge)
        self.view.addSubview(radialGauge)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var r1 = XuniRect(left: 0, top: 150, width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
        var r2 = XuniRect(left: 0, top: Double(100 + (self.view.bounds.size.height/2)), width: Double(self.view.bounds.size.width), height: Double((self.view.bounds.size.height/2) - 100))
        
        linearGauge.frame = CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.height/8)
        linearGauge.rectGauge = r1
        linearGauge.setNeedsDisplay()
        
        radialGauge.frame = CGRectMake(0, 100 + (self.view.bounds.size.height/2), self.view.bounds.size.width, (self.view.bounds.size.height/2) - 100)
        radialGauge.rectGauge = r2
        radialGauge.setNeedsDisplay()
        
        _title.frame = CGRectMake(0, 50, self.view.bounds.size.width, 100)
    }
    
    func animateNextStep(){
        var random = Double(arc4random() % 101)
        linearGauge.updateAnimation.easing = XuniEasing.EaseInOutCubic()
        radialGauge.updateAnimation.easing = XuniEasing.EaseInOutCubic()
        linearGauge.value = random
        radialGauge.value = random
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
