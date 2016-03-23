//
//  CustomCellsController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit
import XuniGaugeKit
class CustomCellsController: UIViewController, FlexGridDelegate {

    var _flex = FlexGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _flex.isReadOnly = true
        _flex.delegate = self
        _flex.autoGenerateColumns = false
        let c1: FlexColumn = FlexColumn()
        c1.header = NSLocalizedString("First Name", comment: "")
        c1.binding = "firstName"
        let c2: FlexColumn = FlexColumn()
        c2.header = NSLocalizedString("Last Name", comment: "")
        c2.binding = "lastName"
        let c3: FlexColumn = FlexColumn()
        c3.header = NSLocalizedString("Total Orders", comment: "")
        c3.binding = "orderTotal"

        _flex.columns.addObject(c1)
        _flex.columns.addObject(c2)
        _flex.columns.addObject(c3)
        
        _flex.selectionMode = FlexSelectionMode.None

        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.isReadOnly = true
        self.starSizing(_flex)
        self.view.addSubview(_flex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatItem(sender: FlexGrid!, panel: FlexGridPanel!, forRange range: FlexCellRange!, inContext context: CGContext!) -> Bool {
        let col = _flex.columns.objectAtIndex(UInt(range.col)) as! FlexColumn
        if(col.header == NSLocalizedString("Total Orders", comment: "")){
            let v = panel.getCellDataForRow(range.row, inColumn: range.col, formatted: false)
            if(v != nil){
                //check for column header... if not equal to header performance  proceed
                if(v.description != NSLocalizedString("Total Orders", comment: "")){
                    let radialGauge = XuniRadialGauge()
                    let lower = XuniGaugeRange(gauge: radialGauge)
                    lower.min = 0
                    lower.max = 40
                    lower.color = UIColor(red: CGFloat(0.133), green: CGFloat(0.694), blue: CGFloat(0.298), alpha: CGFloat(1))
                    let middle = XuniGaugeRange(gauge: radialGauge)
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
                    radialGauge.value = Double(v.description)! * (100.0/90000.0);
                    radialGauge.showRanges = false
                    
                    var r : CGRect = panel.getCellRectForRow(range.row, inColumn: range.col)
                    
                    r.size.width-=4;
                    r.size.height-=4;
                    
                    r.origin.x+=2;
                    r.origin.y+=2;
                    
                    var t = XuniRect(left: 0.0, top: 0.0, width: Double(r.size.width), height: Double(r.size.height))
                    radialGauge.rectGauge = t
                    radialGauge.frame = CGRectMake(0, 0, r.size.width, r.size.height)

                    var image = UIImage()
                    image = UIImage(data: radialGauge.getImage())!
                    image.drawInRect(r)
                    return true
                    }
            }
        }
        return false
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
