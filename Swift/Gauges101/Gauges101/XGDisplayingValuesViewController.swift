//
//  XGDisplayingValuesViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniGaugeKit

class XGDisplayingValuesViewController: UIViewController {

    @IBAction func stepperValueChanged(sender: AnyObject) {
        self.valueDisplay.text = "\(Int(valueStepper.value))"
        self.radialGauge.value = valueStepper.value
        self.linearGauge.value = valueStepper.value
    }

    @IBAction func modeSelected(sender: AnyObject) {
        var st: XuniShowText = XuniShowText.All
        switch modeSelector.selectedSegmentIndex {
            case 0:
                st = XuniShowText.All
                break;
            case 1:
                st = XuniShowText.MinMax
                break;
            case 2:
                st = XuniShowText.Value
                break;
            case 3:
                st = XuniShowText.None
                break;
        default:
            break;
        }

        self.radialGauge.showText = st
        self.linearGauge.showText = st
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.valueDisplay.text = "\(Int(valueStepper.value))"
        self.modeSelected(self)
        self.radialGauge.thickness = 0.6
        self.radialGauge.min = valueStepper.minimumValue
        self.radialGauge.max = valueStepper.maximumValue
        self.radialGauge.value = valueStepper.value
        self.radialGauge.loadAnimation.duration = 2
        self.radialGauge.updateAnimation.duration = 0.5
        self.radialGauge.isReadOnly = false
        self.radialGauge.startAngle = 90
        self.radialGauge.sweepAngle = 90
        radialGauge.gaugeValueChanged.addHandler({(sender: NSObject!, args: XuniEventArgs!) -> Void in
            self.valueStepper.value = self.radialGauge.value
            self.stepperValueChanged(self)
        }, forObject: self)
        self.linearGauge.min = valueStepper.minimumValue
        self.linearGauge.max = valueStepper.maximumValue
        self.linearGauge.value = valueStepper.value
        self.linearGauge.loadAnimation.duration = 2
        self.linearGauge.updateAnimation.duration = 0.5
        self.linearGauge.isReadOnly = false
        self.linearGauge.backgroundColor = UIColor.clearColor()
        linearGauge.gaugeValueChanged.addHandler({(sender: NSObject!, args: XuniEventArgs!) -> Void in
            self.valueStepper.value = self.linearGauge.value
            self.stepperValueChanged(self)
        }, forObject: self)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var valueDisplay: UILabel!
    @IBOutlet weak var valueStepper: UIStepper!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var linearGauge: XuniLinearGauge!
    @IBOutlet weak var radialGauge: XuniRadialGauge!
}
//
//  XGDisplayingValuesViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//