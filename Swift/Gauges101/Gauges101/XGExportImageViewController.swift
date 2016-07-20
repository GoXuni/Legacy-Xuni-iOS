//
//  XGExportImageViewController.h
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit

class XGExportImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.radialGauge.showText = XuniShowText.None
        self.radialGauge.thickness = 0.6
        self.radialGauge.min = 0
        self.radialGauge.max = 100
        self.radialGauge.value = 25
        self.radialGauge.loadAnimation.duration = 2
        self.radialGauge.updateAnimation.duration = 2.5
        self.radialGauge.isReadOnly = true
        self.radialGauge.showText = XuniShowText.All
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "animateNextStep:", userInfo: nil, repeats: true)
        self.snapshotDisplay.hidden = true
    }

    func animateNextStep(sender: AnyObject) {
        let random: Double = Double(Int(arc4random()) % 101)
        
        //radialGauge.updateAnimation.easing = XuniCoreDynamicKit.XuniEasing.EaseOutElastic()
        radialGauge.value = random
    }

    @IBAction func saveSnapshot(sender: AnyObject) {
        if snapshotDisplay.hidden {
            let alert: UIAlertView = UIAlertView(title: NSLocalizedString("Warning",comment:""), message: NSLocalizedString("You should take the snapshot before saving it to Camera Roll", comment: ""), delegate: nil, cancelButtonTitle: NSLocalizedString("OK",comment:""))
            alert.show()
        }
        else {
            
            UIImageWriteToSavedPhotosAlbum(snapshotDisplay.image!, self, "imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:",nil)
        }
    }

    func imageSavedToPhotoAlbum(image: UIImage, finishedSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        var message: String
        var title: String
        if error == nil {
            title = NSLocalizedString("Success",comment:"")
            message = NSLocalizedString("Image was saved to Camera Roll succesfully",comment:"")
        }
        else {
            title = NSLocalizedString("Failure", comment:"")
            message = error!.description
        }
        let alert: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: NSLocalizedString("OK",comment:""))
        alert.show()
        self.radialGauge.hidden = false
        self.snapshotDisplay.hidden = true
    }

    @IBAction func takeSnapshot(sender: AnyObject) {
        let image: UIImage = UIImage(data: radialGauge.getImage())!
        snapshotDisplay.image = image
        self.radialGauge.hidden = true
        self.snapshotDisplay.hidden = false
        self.snapshotDisplay.layer.borderWidth = 10
        self.snapshotDisplay.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var radialGauge: XuniRadialGauge!
    @IBOutlet weak var snapshotDisplay: UIImageView!
}
//
//  XGExportImageViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import XuniGaugeDynamicKit
//#define LOC(A) NSLocalizedString(A, nil)