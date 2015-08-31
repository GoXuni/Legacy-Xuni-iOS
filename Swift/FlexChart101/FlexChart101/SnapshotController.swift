//
//  SnapshotController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit

class SnapshotController: UIViewController {

    
    var _chart = FlexChart()
    var _snapshotButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.tooltip.isVisible = true
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
        _snapshotButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        _snapshotButton.setTitle("Take a snapshot", forState: UIControlState.Normal)
        _snapshotButton.addTarget(self, action: "snapshotButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(_chart)
        self.view.addSubview(_snapshotButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chart.frame = CGRectMake(5, 115, self.view.bounds.size.width-10, self.view.bounds.size.height-115)
        _snapshotButton.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50);
    }
    
    func snapshotButtonClicked(){
        var image = UIImage(data: _chart.getImage())
        UIImageWriteToSavedPhotosAlbum(image, self, "imageSavedToPhotoAlbum:error:contextInfo:", nil)
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
        var alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
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
