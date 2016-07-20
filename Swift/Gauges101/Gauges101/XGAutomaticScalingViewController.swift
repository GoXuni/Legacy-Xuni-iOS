//
//  XGAutomaticScalingViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
class XGAutomaticScalingViewController: UIViewController {

    @IBAction func angleChanged(sender: AnyObject) {
        self.radialGauge.startAngle = self.startAngleStepper.value
        self.radialGauge.sweepAngle = self.sweepAngleStepper.value
        self.startAngleDisplay.text = "\(Int(radialGauge.startAngle))"
        self.sweepAngleDisplay.text = "\(Int(radialGauge.sweepAngle))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.radialGauge.thickness = 0.6
        self.radialGauge.min = 0
        self.radialGauge.max = 200
        self.radialGauge.value = 25
        self.radialGauge.loadAnimation.duration = 2
        self.radialGauge.updateAnimation.duration = 3.5
        self.radialGauge.isReadOnly = true
        self.radialGauge.startAngle = 90
        self.radialGauge.sweepAngle = 90
        self.radialGauge.backgroundColor = UIColor.clearColor()
        self.radialGauge.pointerColor = UIColor.whiteColor()
        self.radialGauge.faceBorderWidth = 1
        self.radialGauge.faceBorderColor = UIColor.whiteColor()
        self.radialGauge.faceColor = UIColor.clearColor()
        self.radialGauge.valueFontColor = UIColor.whiteColor()
        self.radialGauge.minFontColor = UIColor.whiteColor()
        self.radialGauge.maxFontColor = UIColor.whiteColor()
        self.radialGauge.valueFont = UIFont(name: "Optima", size: 19)
        self.angleChanged(self)
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "generateRandomNumber:", userInfo: nil, repeats: true)
    }

    func generateRandomNumber(sender: AnyObject) {
        self.radialGauge.value = Double(Int(arc4random()) % 201)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var startAngleStepper: UIStepper!
    @IBOutlet weak var startAngleDisplay: UILabel!
    @IBOutlet weak var sweepAngleDisplay: UILabel!
    @IBOutlet weak var sweepAngleStepper: UIStepper!
    @IBOutlet weak var radialGauge: XuniRadialGauge!
}
//
//  XGAutomaticScalingViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import XuniGaugeDynamicKit