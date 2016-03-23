//
//  XGDirectionViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
class XGDirectionViewController: UIViewController {

    @IBAction func modeSelector(sender: AnyObject) {
        switch modeSel.selectedSegmentIndex {
            case 0, 1:
                self.view!.removeConstraint(bulletGraphTop)
                linearGauge.removeConstraint(linearWidth)
                self.view!.removeConstraint(linearGaugeBottom)
                bulletGraph.removeConstraint(bulletWidth)
                self.view!.removeConstraint(bulletGraphBottom)
                linearGauge.addConstraint(linearHeight)
                self.view!.addConstraint(linearGaugeTrailing)
                self.view!.addConstraint(gaugesInterspacing)
                bulletGraph.addConstraint(bulletHeight)
                self.view!.addConstraint(bulletGraphLeading)
                break;
            case 2, 3:
                linearGauge.removeConstraint(linearHeight)
                self.view!.removeConstraint(linearGaugeTrailing)
                self.linearGauge.removeConstraint(linearGaugeTrailing)
                self.view!.removeConstraint(gaugesInterspacing)
                bulletGraph.removeConstraint(bulletHeight)
                self.view!.removeConstraint(bulletGraphLeading)
                self.view!.addConstraint(bulletGraphTop)
                linearGauge.addConstraint(linearWidth)
                self.view!.addConstraint(linearGaugeBottom)
                bulletGraph.addConstraint(bulletWidth)
                self.view!.addConstraint(bulletGraphBottom)
                break;
            default:
                break;
        }

        switch modeSel.selectedSegmentIndex {
            case 0:
                self.linearGauge.direction = XuniGaugeDirection.Right
                self.bulletGraph.direction = XuniGaugeDirection.Right
                break;
            case 1:
                self.linearGauge.direction = XuniGaugeDirection.Left
                self.bulletGraph.direction = XuniGaugeDirection.Left
                break;
            case 2:
                self.linearGauge.direction = XuniGaugeDirection.Down
                self.bulletGraph.direction = XuniGaugeDirection.Down
                break;
            case 3:
                self.linearGauge.direction = XuniGaugeDirection.Up
                self.bulletGraph.direction = XuniGaugeDirection.Up
                break;
        default:
            break;
        }

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.modeSelector(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.linearGauge.isReadOnly = false
        self.bulletGraph.isReadOnly = false
        self.linearGauge.backgroundColor = UIColor.clearColor()
        self.bulletGraph.backgroundColor = UIColor.clearColor()
        self.linearGauge.showText = XuniShowText.All
        self.bulletGraph.showText = XuniShowText.All
        self.bulletGraph.backgroundColor = UIColor.clearColor()
        self.linearGauge.backgroundColor = UIColor.clearColor()
        self.bulletGraph.pointerColor = UIColor.whiteColor()
        self.linearGauge.pointerColor = UIColor.whiteColor()
        self.bulletGraph.faceBorderWidth = 1
        self.linearGauge.faceBorderWidth = 1
        self.bulletGraph.faceBorderColor = UIColor.whiteColor()
        self.linearGauge.faceBorderColor = UIColor.whiteColor()
        self.linearGauge.faceColor = UIColor.clearColor()
        self.bulletGraph.faceColor = UIColor.whiteColor()
        self.bulletGraph.valueFontColor = UIColor.blueColor()
        self.linearGauge.valueFontColor = UIColor.blueColor()
        self.bulletGraph.minFontColor = UIColor.whiteColor()
        self.linearGauge.minFontColor = UIColor.whiteColor()
        self.bulletGraph.maxFontColor = UIColor.whiteColor()
        self.linearGauge.maxFontColor = UIColor.whiteColor()
        self.bulletGraph.valueFont = UIFont(name: "Optima", size: 19)
        self.linearGauge.valueFont = UIFont(name: "Optima", size: 19)
        self.bulletGraph.thickness = 0.6
        self.bulletGraph.min = 0
        self.bulletGraph.max = 100
        self.bulletGraph.bad = 45
        self.bulletGraph.good = 80
        self.bulletGraph.target = 90
        self.bulletGraph.value = 80
        self.bulletGraph.pointer.thickness = 0.5
        self.bulletGraph.loadAnimation.duration = 2
        self.bulletGraph.updateAnimation.duration = 0.5
        self.linearGauge.thickness = 0.6
        self.linearGauge.min = 0
        self.linearGauge.max = 100
        self.linearGauge.value = 80
        self.linearGauge.loadAnimation.duration = 2
        self.linearGauge.updateAnimation.duration = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var modeSel: UISegmentedControl!
    @IBOutlet weak var linearGauge: XuniLinearGauge!
    @IBOutlet weak var bulletGraph: XuniBulletGraph!
    @IBOutlet weak var linearWidth: NSLayoutConstraint!
    @IBOutlet weak var linearHeight: NSLayoutConstraint!
    @IBOutlet weak var bulletWidth: NSLayoutConstraint!
    @IBOutlet weak var bulletHeight: NSLayoutConstraint!
    @IBOutlet weak var gaugesInterspacing: NSLayoutConstraint!
    @IBOutlet weak var linearGaugeTrailing: NSLayoutConstraint!
    @IBOutlet weak var bulletGraphLeading: NSLayoutConstraint!
    @IBOutlet weak var linearGaugeBottom: NSLayoutConstraint!
    @IBOutlet weak var bulletGraphBottom: NSLayoutConstraint!
    @IBOutlet weak var bulletGraphTop: NSLayoutConstraint!
}
//
//  XGDirectionViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import XuniGaugeKit