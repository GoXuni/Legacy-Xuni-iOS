//
//  SnapshotController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit

class SnapshotController: UIViewController {
    var radialGauge = XuniRadialGauge()
    var snapshotButton = UIButton()
    var snapshotImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        snapshotButton = UIButton(type: UIButtonType.System)
        snapshotButton.setTitle("Take a snapshot", forState: UIControlState.Normal)
        snapshotButton.addTarget(self, action: "snapshotButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)

        radialGauge.showText = XuniShowText.All
        radialGauge.thickness = 0.6
        radialGauge.min = 0
        radialGauge.max = 100
        radialGauge.value = 25
        radialGauge.loadAnimation.duration = 2
        radialGauge.updateAnimation.duration = 2
        radialGauge.pointer.thickness = 0.5
        self.view.addSubview(snapshotButton)
        self.view.addSubview(radialGauge)
        self.view.addSubview(snapshotImage)
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "animateNextStep", userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let r1 = XuniRect(left: 5, top: 115, width: Double(self.view.bounds.size.width-10), height: Double(self.view.bounds.size.height/2 - 65))
        
        radialGauge.frame = CGRectMake(5, 115, self.view.bounds.size.width-10, self.view.bounds.size.height/2 - 65)
        radialGauge.rectGauge = r1
        snapshotImage.frame = CGRectMake(5, self.view.bounds.size.height / 2 + 65, self.view.bounds.size.width - 10, self.view.bounds.size.height/2 - 65)
        snapshotButton.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50)
        radialGauge.setNeedsDisplay()
    }
    
    func animateNextStep(){
        radialGauge.value = Double(arc4random() % 101)
    }
    func snapshotButtonClicked(){
        let image = UIImage(data: radialGauge.getImage())
        UIImageWriteToSavedPhotosAlbum(image!, self, "imageSavedToPhotoAlbum:error:contextInfo:", nil)
        snapshotImage.image = image
    }
    func imageSavedToPhotoAlbum(image: UIImage!, error: NSError!, contextInfo: UnsafePointer<Void>){
        var message = String()
        var title = String()
        if(error == nil){
            title = "Success"
            message = "Image was saved to Camera Roll successfully"
        }
        else{
            title = "Failure"
            message = error.description
        }
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show();
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
