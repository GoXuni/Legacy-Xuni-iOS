//
//  CustomCellsController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexGridKit
import XuniGaugeKit
class CustomCellsController: UIViewController, FlexGridDelegate {

    var _flex = FlexGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _flex.isReadOnly = true
        _flex.delegate = self
        _flex.autoGenerateColumns = false
        var c1 = FlexColumn()
        c1.binding = "customerID"
        c1.width = 100
        var c2 = FlexColumn()
        c2.binding = "first"
        var c3 = FlexColumn()
        c3.header = "performance"
        c3.binding = "weight"

        _flex.columns.addObject(c1)
        _flex.columns.addObject(c2)
        _flex.columns.addObject(c3)

        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.isReadOnly = true
        self.starSizing(_flex)
        self.view.addSubview(_flex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func formatItem(args: FlexFormatItemEventArgs!) {
        var col = _flex.columns.objectAtIndex(UInt(args.col)) as! FlexColumn
        if(col.header == "performance"){
            var v = args.panel.getCellDataForRow(args.row, inColumn: args.col, formatted: false)
            if(v != nil){
                //check for column header... if not equal to header performance  proceed
                if(v.description != "performance"){
                    var radialGauge = XuniRadialGauge()
                    var lower = XuniGaugeRange(gauge: radialGauge)
                    lower.min = 0
                    lower.max = 40
                    lower.color = UIColor(red: CGFloat(0.133), green: CGFloat(0.694), blue: CGFloat(0.298), alpha: CGFloat(1))
                    var middle = XuniGaugeRange(gauge: radialGauge)
                    middle.min = 40
                    middle.max = 80
                    middle.color = UIColor(red: CGFloat(1), green: CGFloat(0.502), blue: CGFloat(0.502), alpha: CGFloat(1))
                    var upper = XuniGaugeRange(gauge: radialGauge)
                    upper.min = 80
                    upper.max = 100
                    upper.color = UIColor(red: CGFloat(0), green: CGFloat(0.635), blue: CGFloat(0.91), alpha: CGFloat(1))
                    
                    radialGauge.ranges.addObject(lower)
                    radialGauge.ranges.addObject(middle)
                    radialGauge.ranges.addObject(upper)
                    
                    radialGauge.showText = XuniShowText.None
                    radialGauge.thickness = 0.6
                    radialGauge.min = 0
                    radialGauge.max = 100
                    radialGauge.loadAnimation = nil
                    radialGauge.value = Double(v.description.toInt()! / 3);
                    radialGauge.showRanges = false
                    
                    var r : CGRect = args.panel.getCellRectForRow(args.row, inColumn: args.col)
                    var t = XuniRect(left: 0.0, top: 0.0, width: Double(r.size.width), height: Double(r.size.height))
                    radialGauge.rectGauge = t
                    radialGauge.frame = CGRectMake(0, 0, r.size.width, r.size.height)

                    var image = UIImage()
                    image = UIImage(data: radialGauge.getImage())!
                    image.drawInRect(r)
                    args.cancel = true               }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65)
        _flex.setNeedsDisplay()
    }
    func starSizing(g: FlexGrid){
        for var i : UInt = 0; i < g.columns.count; i++ {
            var c = FlexColumn()
            c = g.columns.objectAtIndex(i) as! FlexColumn
            c.widthType = FlexColumnWidth.Star
            c.width = (i == 0) ? 5 : (i == 3) ? 3 : 4
        }
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
