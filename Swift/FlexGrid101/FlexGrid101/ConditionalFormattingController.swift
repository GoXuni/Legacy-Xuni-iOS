//
//  ConditionalFormattingController.swift
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class ConditionalFormattingController: UIViewController, FlexGridDelegate {
    var _flex = FlexGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _flex.autoGenerateColumns = false
        let c1: FlexColumn = FlexColumn()
        c1.binding = "firstName"
        c1.header = "First Name"
        c1.width = 100
        let c2: FlexColumn = FlexColumn()
        c2.binding = "lastName"
        c2.header = "Last Name"
        let c3: FlexColumn = FlexColumn()
        c3.binding = "orderTotal"
        c3.header = "Total"
        c3.format = "C"
        let c4: FlexColumn = FlexColumn()
        c4.binding = "orderCount"
        c4.header = "Count"
        c4.format = "N1"
        _flex.columns.addObject(c1)
        _flex.columns.addObject(c2)
        _flex.columns.addObject(c3)
        _flex.columns.addObject(c4)

        
        _flex.isReadOnly = true
        _flex.itemsSource = CustomerData.getCustomerData(100)
        
        _flex.delegate = self
        
        self.view.addSubview(_flex)
    }
    
    func formatItem(args: FlexFormatItemEventArgs!) {
        if args.panel.cellType == FlexCellType.Cell {
            let g: FlexGrid = _flex
            let col: FlexColumn = g.columns.objectAtIndex(UInt(args.col)) as! FlexColumn
            if col.binding == "orderCount" {
                let n: Int? = args.panel.getCellDataForRow(args.row, inColumn: args.col, formatted: false) as? Int
                if n != nil {
                    if n! >= 50 {
                        let r: CGRect = args.panel.getCellRectForRow(args.row, inColumn: args.col)
                        CGContextSetFillColorWithColor(args.context, UIColor(red: 0.15, green: 0.31, blue: 0.07, alpha: 1.0).CGColor)
                        CGContextFillRect(args.context, r)
                    }
                    else {
                        if n! < 50 {
                            let r: CGRect = args.panel.getCellRectForRow(args.row, inColumn: args.col)
                            CGContextSetFillColorWithColor(args.context, UIColor.redColor().CGColor)
                            CGContextFillRect(args.context, r)
                        }
                    }
                    args.panel.textAttributes.setValue(UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
                }
            }
            if col.binding == "orderTotal" {
                let n: Int? = args.panel.getCellDataForRow(args.row, inColumn: args.col, formatted: false) as? Int
                if n != nil {
                    if n! >= 5000 {
                        args.panel.textAttributes.setValue(UIColor(red: 0.15, green: 0.31, blue: 0.07, alpha: 1.0), forKey: NSForegroundColorAttributeName)
                    }
                    else {
                        if n! < 5000 {
                            args.panel.textAttributes.setValue(UIColor.redColor(), forKey: NSForegroundColorAttributeName)
                        }
                    }
                }
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.navigationController == nil) {return;}
        
        let ss = UIApplication.sharedApplication().statusBarFrame.size.height + self.navigationController!.navigationBar.intrinsicContentSize().height;
        
        _flex.frame = CGRectMake(0, ss, self.view.bounds.size.width, self.view.bounds.size.height - ss)
        _flex.setNeedsDisplay()
    }


}