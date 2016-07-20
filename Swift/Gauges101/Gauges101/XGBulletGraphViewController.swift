//
//  XGBulletGraphViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
class XGBulletGraphViewController: UIViewController {

    @IBAction func stepperChanged(sender: AnyObject) {
        self.bulletGraph.bad = badStepper.value
        self.bulletGraph.good = goodStepper.value
        self.bulletGraph.target = targetStepper.value
        self.targetDisplay.text = "\(Int(targetStepper.value))"
        self.badDisplay.text = "\(Int(badStepper.value))"
        self.goodDisplay.text = "\(Int(goodStepper.value))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bulletGraph.showText = XuniShowText.None
        self.bulletGraph.min = 0
        self.bulletGraph.max = 100
        self.bulletGraph.value = 30
        self.bulletGraph.loadAnimation.duration = 2
        self.bulletGraph.updateAnimation.duration = 0.5
        self.bulletGraph.isReadOnly = false
        self.bulletGraph.bad = 45
        self.bulletGraph.good = 80
        self.bulletGraph.target = 90
        self.bulletGraph.pointer.thickness = 0.33
        self.bulletGraph.pointerColor = UIColor.blackColor()
        self.stepperChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var badDisplay: UILabel!
    @IBOutlet weak var goodDisplay: UILabel!
    @IBOutlet weak var targetDisplay: UILabel!
    @IBOutlet weak var badStepper: UIStepper!
    @IBOutlet weak var goodStepper: UIStepper!
    @IBOutlet weak var targetStepper: UIStepper!
    @IBOutlet weak var bulletGraph: XuniBulletGraph!
}
//
//  XGBulletGraphViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import XuniGaugeDynamicKit