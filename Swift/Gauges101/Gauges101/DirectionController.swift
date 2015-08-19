//
//  DirectionController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniGaugeKit
class DirectionController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var linearGauge = XuniLinearGauge()
    var bulletGraph = XuniBulletGraph()
    var pickerView = UIPickerView()
    var _title = UILabel()
    var _pickerData = NSMutableArray()
    var _isHorizontal = Bool();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var min = 0.0
        var max = 100.0
        var val = 25.0
        var bad = 45.0
        var good = 80.0
        var target = 90.0
        _isHorizontal = true
        
        _pickerData = ["Right", "Left", "Down", "Up"]
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        pickerView.hidden = false
    
        _title.textAlignment = NSTextAlignment.Center
        _title.textColor = UIColor.blackColor()
        _title.text = "Direction"

        linearGauge.showText = XuniShowText.None
        linearGauge.thickness = 0.6
        linearGauge.min = min
        linearGauge.max = max
        linearGauge.value = val
        linearGauge.loadAnimation.duration = 2
        linearGauge.updateAnimation.duration = 0.5
        linearGauge.showRanges = false;
        
        bulletGraph.isReadOnly = false;
        bulletGraph.showText = XuniShowText.None
        bulletGraph.thickness = 0.6
        bulletGraph.min = min
        bulletGraph.max = max
        bulletGraph.bad = bad
        bulletGraph.good = good
        bulletGraph.target = target
        bulletGraph.value = val
        bulletGraph.pointer.thickness = 0.5
        bulletGraph.loadAnimation.duration = 2
        bulletGraph.updateAnimation.duration = 0.5
        
        self.view.addSubview(_title)
        self.view.addSubview(pickerView)
        self.view.addSubview(linearGauge)
        self.view.addSubview(bulletGraph)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var r1 = XuniRect(left: 0, top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
        var r2 = XuniRect(left: 0, top: Double(self.view.bounds.size.height*3/4), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/6))
        
        linearGauge.frame = CGRectMake(0, (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/8)
        linearGauge.rectGauge = r1
        bulletGraph.frame = CGRectMake(0, (self.view.bounds.size.height*3/4), self.view.bounds.size.width, self.view.bounds.size.height/6)
        bulletGraph.rectGauge = r2
        pickerView.frame = CGRectMake(self.view.bounds.size.width/4, 65, self.view.bounds.size.width/2, 162)
        _title.frame = CGRectMake(0, 55, self.view.bounds.size.width, 50)
        linearGauge.setNeedsDisplay()
        bulletGraph.setNeedsDisplay()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var r1 = XuniRect()
        var r2 = XuniRect()
        if(row == 0){
            linearGauge.direction = XuniGaugeDirection.Right
            bulletGraph.direction = XuniGaugeDirection.Right
            if (_isHorizontal == false){
                linearGauge.frame = CGRectMake(0, (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/8)
                bulletGraph.frame = CGRectMake(0, (self.view.bounds.size.height*3/4), self.view.bounds.size.width, self.view.bounds.size.height/6)
                r1 = XuniRect(left: 0, top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
                r2 = XuniRect(left: 0, top: Double(self.view.bounds.size.height*3/4), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/6))
                linearGauge.rectGauge = r1
                bulletGraph.rectGauge = r2
                linearGauge.setNeedsDisplay()
                bulletGraph.setNeedsDisplay()
                _isHorizontal = true
            }
        }
        else if(row == 1){
            linearGauge.direction = XuniGaugeDirection.Left
            bulletGraph.direction = XuniGaugeDirection.Left
            if (_isHorizontal == false){
                linearGauge.frame = CGRectMake(0, (self.view.bounds.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height/8)
                bulletGraph.frame = CGRectMake(0, (self.view.bounds.size.height*3/4), self.view.bounds.size.width, self.view.bounds.size.height/6)
                r1 = XuniRect(left: 0, top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/8))
                r2 = XuniRect(left: 0, top: Double(self.view.bounds.size.height*3/4), width: Double(self.view.bounds.size.width), height: Double(self.view.bounds.size.height/6))
                linearGauge.rectGauge = r1
                bulletGraph.rectGauge = r2
                linearGauge.setNeedsDisplay()
                bulletGraph.setNeedsDisplay()
                _isHorizontal = true
            }
        }
        else if(row == 2){
            linearGauge.direction = XuniGaugeDirection.Down
            bulletGraph.direction = XuniGaugeDirection.Down
            if (_isHorizontal == true){
                linearGauge.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2)
                bulletGraph.frame = CGRectMake(self.view.bounds.size.width/4, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2)
                r1 = XuniRect(left: 0, top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width/4), height: Double(self.view.bounds.size.height/2))
                r2 = XuniRect(left: Double(self.view.bounds.size.width/4), top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width/4), height: Double(self.view.bounds.size.height/2))
                linearGauge.rectGauge = r1
                bulletGraph.rectGauge = r2
                linearGauge.setNeedsDisplay()
                bulletGraph.setNeedsDisplay()
                _isHorizontal = false
            }
        }
        else if(row == 3){
            linearGauge.direction = XuniGaugeDirection.Up
            bulletGraph.direction = XuniGaugeDirection.Up
            if (_isHorizontal == true){
                linearGauge.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2)
                bulletGraph.frame = CGRectMake(self.view.bounds.size.width/4, self.view.bounds.size.height/2, self.view.bounds.size.width/4, self.view.bounds.size.height/2)
                r1 = XuniRect(left: 0, top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width/4), height: Double(self.view.bounds.size.height/2))
                r2 = XuniRect(left: Double(self.view.bounds.size.width/4), top: Double(self.view.bounds.size.height/2), width: Double(self.view.bounds.size.width/4), height: Double(self.view.bounds.size.height/2))
                linearGauge.rectGauge = r1
                bulletGraph.rectGauge = r2
                linearGauge.setNeedsDisplay()
                bulletGraph.setNeedsDisplay()
                _isHorizontal = false
            }
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return _pickerData.objectAtIndex(row) as! String
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
