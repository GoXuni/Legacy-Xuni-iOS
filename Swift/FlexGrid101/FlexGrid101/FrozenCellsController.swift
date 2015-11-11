//
//  FrozenCellsController.swift
//  FlexGrid101
//
//  Created by Mykola Kotyuck on 21.10.15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class FrozenCellsController: UIViewController {
    var _flex = FlexGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _flex.isReadOnly = true
        _flex.columnHeaderFont = UIFont.boldSystemFontOfSize(_flex.columnHeaderFont.pointSize)
        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.autoSizeColumn(0, to: Int32(Int(_flex.columns.count)-1))
        _flex.frozenRows = 1
        _flex.frozenColumns = 1
        
        self.view.addSubview(_flex)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
