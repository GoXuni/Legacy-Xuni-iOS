//
//  StarSizingController.swift
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class StarSizingController: UIViewController {
    var flex = FlexGrid()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        flex.columnHeaderFont = UIFont.boldSystemFontOfSize(flex.columnHeaderFont.pointSize)
        flex.autoGenerateColumns = false
        let c1: FlexColumn = FlexColumn()
        c1.binding = "customerID"
        c1.header = NSLocalizedString("ID", comment: "")
        c1.widthType = FlexColumnWidth.Star
        c1.width = 1
        let c2: FlexColumn = FlexColumn()
        c2.binding = "firstName"
        c2.header = NSLocalizedString("First Name", comment: "")
        c2.widthType = FlexColumnWidth.Star
        c2.width = 3
        let c3: FlexColumn = FlexColumn()
        c3.binding = "lastName"
        c3.header = NSLocalizedString("Last Name", comment: "")
        c3.widthType = FlexColumnWidth.Star
        c3.width = 3
        let c4: FlexColumn = FlexColumn()
        c4.binding = "orderTotal"
        c4.header = NSLocalizedString("Total", comment: "")
        c4.format = "C"
        c4.widthType = FlexColumnWidth.Star
        c4.width = 2
        flex.columns.addObject(c1)
        flex.columns.addObject(c2)
        flex.columns.addObject(c3)
        flex.columns.addObject(c4)
        flex.itemsSource = CustomerData.getCustomerData(100)
        flex.isReadOnly = true
        flex.tag = 1
        self.view.addSubview(flex)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.navigationController == nil) {return;}
        
        let ss = UIApplication.sharedApplication().statusBarFrame.size.height + self.navigationController!.navigationBar.intrinsicContentSize().height;
        
        flex.frame = CGRectMake(0, ss, self.view.bounds.size.width, self.view.bounds.size.height - ss)
        flex.setNeedsDisplay()
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
