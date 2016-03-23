//
//  XGGettingStartedViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniGaugeKit

class XGGettingStartedViewController: UIViewController {

    @IBAction func stepperValueChanged(sender: AnyObject) {
        self.valueDisplay.text = "\(Int(valueStepper.value))"
        self.radialGauge.value = valueStepper.value
        self.linearGauge.value = valueStepper.value
        self.bulletGraph.value = valueStepper.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.valueDisplay.text = "\(Int(valueStepper.value))"
        self.radialGauge.showText = XuniShowText.None
        self.radialGauge.thickness = 0.6
        self.radialGauge.min = valueStepper.minimumValue
        self.radialGauge.max = valueStepper.maximumValue
        self.radialGauge.value = valueStepper.value
        self.radialGauge.loadAnimation.duration = 2
        self.radialGauge.updateAnimation.duration = 0.5
        self.radialGauge.isReadOnly = false
        self.radialGauge.showText = XuniShowText.None
        radialGauge.gaugeValueChanged.addHandler({(sender: NSObject!, args: XuniEventArgs!) -> Void in
            self.valueStepper.value = self.radialGauge.value
            self.stepperValueChanged(self)
        }, forObject: self)
        self.linearGauge.showText = XuniShowText.None
        self.linearGauge.min = valueStepper.minimumValue
        self.linearGauge.max = valueStepper.maximumValue
        self.linearGauge.value = valueStepper.value
        self.linearGauge.loadAnimation.duration = 2
        self.linearGauge.updateAnimation.duration = 0.5
        self.linearGauge.isReadOnly = false
        
        
        linearGauge.gaugeValueChanged.addHandler({(sender: NSObject!, args: XuniEventArgs!) -> Void in
            self.valueStepper.value = self.linearGauge.value
            self.stepperValueChanged(self)
        }, forObject: self)
        self.bulletGraph.showText = XuniShowText.None
        self.bulletGraph.min = valueStepper.minimumValue
        self.bulletGraph.max = valueStepper.maximumValue
        self.bulletGraph.value = valueStepper.value
        self.bulletGraph.loadAnimation.duration = 2
        self.bulletGraph.updateAnimation.duration = 0.5
        self.bulletGraph.isReadOnly = false
        self.bulletGraph.bad = 45
        self.bulletGraph.good = 80
        self.bulletGraph.target = 90
        bulletGraph.gaugeValueChanged.addHandler({(sender: NSObject!, args: XuniEventArgs!) -> Void in
            self.valueStepper.value = self.bulletGraph.value
            self.stepperValueChanged(self)
        }, forObject: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var radialGauge: XuniRadialGauge!
    @IBOutlet weak var bulletGraph: XuniBulletGraph!
    @IBOutlet weak var linearGauge: XuniLinearGauge!
    @IBOutlet weak var valueStepper: UIStepper!
    @IBOutlet weak var valueDisplay: UILabel!
}
//
//  XGGettingStartedViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//