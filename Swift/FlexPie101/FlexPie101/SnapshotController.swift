//
//  SnapshotController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexPieKit

class SnapshotController: UIViewController {
    
    var _pieChart = FlexPie()
    var _snapshotButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var pieData = NSMutableArray()
        pieData = PieChartData.demoData()
        _pieChart.binding = "value"
        _pieChart.bindingName = "name"
        _pieChart.itemsSource = pieData
        _pieChart.tooltip.isVisible = true
        
        _snapshotButton = UIButton(type: UIButtonType.System)
        _snapshotButton.setTitle("Take a snapshot", forState: UIControlState.Normal)
        _snapshotButton.addTarget(self, action: "snapshotButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(_pieChart)
        self.view.addSubview(_snapshotButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _pieChart.frame = CGRectMake(5, self.view.bounds.size.height/3, self.view.bounds.size.width-10, self.view.bounds.size.height/2);
        _snapshotButton.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50);

    }
    
    func snapshotButtonClicked(){
        let image = UIImage(data: _pieChart.getImage())
        UIImageWriteToSavedPhotosAlbum(image!, self, "imageSavedToPhotoAlbum:error:contextInfo:", nil)
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

