//
//  GettingStartedController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexGridKit

class GettingStartedController: UIViewController {
    var _flex = FlexGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _flex.isReadOnly = true
        _flex.itemsSource = CustomerData.getCustomerData(100)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
