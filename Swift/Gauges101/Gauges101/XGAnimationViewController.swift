//
//  XGAnimationViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniGaugeDynamicKit

class XGAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.radialGauge.thickness = 0.6
        self.radialGauge.min = 0
        self.radialGauge.max = 100
        self.radialGauge.value = 25
        self.radialGauge.loadAnimation.duration = 2
        self.radialGauge.updateAnimation.duration = 2.5
        self.radialGauge.isReadOnly = true
        self.linearGauge.min = 0
        self.linearGauge.max = 100
        self.linearGauge.value = 25
        self.linearGauge.loadAnimation.duration = 2
        self.linearGauge.updateAnimation.duration = 2.5
        self.linearGauge.isReadOnly = true
        self.linearGauge.backgroundColor = UIColor.clearColor()
        self.radialGauge.backgroundColor = UIColor.clearColor()
        self.linearGauge.backgroundColor = UIColor.clearColor()
        self.radialGauge.pointerColor = UIColor.whiteColor()
        self.linearGauge.pointerColor = UIColor.whiteColor()
        self.radialGauge.faceBorderWidth = 1
        self.linearGauge.faceBorderWidth = 1
        self.radialGauge.faceBorderColor = UIColor.whiteColor()
        self.linearGauge.faceBorderColor = UIColor.whiteColor()
        self.radialGauge.faceColor = UIColor.clearColor()
        self.linearGauge.faceColor = UIColor.clearColor()
        self.radialGauge.valueFontColor = UIColor.whiteColor()
        self.linearGauge.valueFontColor = UIColor.blueColor()
        self.radialGauge.minFontColor = UIColor.whiteColor()
        self.linearGauge.minFontColor = UIColor.whiteColor()
        self.radialGauge.maxFontColor = UIColor.whiteColor()
        self.linearGauge.maxFontColor = UIColor.whiteColor()
        self.radialGauge.valueFont = UIFont(name: "Optima", size: 19)
        self.linearGauge.valueFont = UIFont(name: "Optima", size: 19)
        // Create ranges.
        let lower: XuniGaugeRange = XuniGaugeRange(gauge: linearGauge)
        lower.min = 0
        lower.max = 40
        lower.color = UIColor(red: 0.133, green: 0.694, blue: 0.298, alpha: 1)
        lower.borderColor = UIColor.whiteColor()
        lower.borderWidth = 1
        let middle: XuniGaugeRange = XuniGaugeRange(gauge: linearGauge)
        middle.min = 40
        middle.max = 80
        middle.color = UIColor(red: 1, green: 0.502, blue: 0.502, alpha: 1)
        middle.borderColor = UIColor.whiteColor()
        middle.borderWidth = 1
        let upper: XuniGaugeRange = XuniGaugeRange(gauge: linearGauge)
        upper.min = 80
        upper.max = 100
        upper.color = UIColor(red: 0, green: 0.635, blue: 0.91, alpha: 1)
        upper.borderColor = UIColor.whiteColor()
        upper.borderWidth = 1
        // Add ranges.
        linearGauge.ranges.addObject(lower)
        linearGauge.ranges.addObject(middle)
        linearGauge.ranges.addObject(upper)
        radialGauge.ranges.addObject(lower)
        radialGauge.ranges.addObject(middle)
        radialGauge.ranges.addObject(upper)
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "animateNextStep:", userInfo: nil, repeats: true)
    }

    func animateNextStep(sender: AnyObject) {
        let random: Double = Double(Int(arc4random()) % 101)
        linearGauge.updateAnimation.easing = XuniEasing.EaseOutBounce()
        radialGauge.updateAnimation.easing = XuniEasing.EaseOutBounce()
        linearGauge.value = random
        radialGauge.value = random
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var linearGauge: XuniLinearGauge!
    @IBOutlet weak var radialGauge: XuniRadialGauge!
}
//
//  XGAnimationViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import XuniGaugeDynamicKit