//
//  GettingStartedController.swift
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniCalendarKit

class GettingStartedController: UIViewController {

    var _calendar = XuniCalendar(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Getting Started"

        // Do any additional setup after loading the view.
        self.view.addSubview(_calendar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = self.view.bounds.size
        let width = min(size.width, size.height)
        _calendar.frame = CGRectMake(0, 75, width, width - 75)
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
