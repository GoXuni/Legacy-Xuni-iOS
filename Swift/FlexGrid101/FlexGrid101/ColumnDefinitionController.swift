//
//  ColumnDefinitionController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class ColumnDefinitionController: UIViewController {
    var _flex = FlexGrid()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        _flex.autoGenerateColumns = false
        let c1 = FlexColumn()
        c1.binding = "customerID"
        c1.header = NSLocalizedString("ID", comment: "")
        c1.width = 100
        let c2 = FlexColumn()
        c2.binding = "firstName"
        c2.header = NSLocalizedString("First name", comment: "")
        let c3 = FlexColumn()
        c3.header = NSLocalizedString("Last name", comment: "")
        c3.binding = "lastName"
        let c4 = FlexColumn()
        c4.binding = "orderTotal"
        c4.header = NSLocalizedString("Total orders", comment: "")
        c4.format = "N1"
        _flex.columns.addObject(c1)
        _flex.columns.addObject(c2)
        _flex.columns.addObject(c3)
        _flex.columns.addObject(c4)
        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.isReadOnly = true
        self.starSizing(_flex)
        self.view.addSubview(_flex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            c.width = (i == 0) ? 3 : (i == 3) ? 3 : 4
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
