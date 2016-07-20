//
//  CustomAppearanceController.swift
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniCalendarKit

class CustomAppearanceController: UIViewController {

    var _calendar = XuniCalendar(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Custom Appearance", comment: "")

        // Do any additional setup after loading the view.
        _calendar.borderColor = UIColor.blackColor()
        _calendar.borderWidth = 5.0
        
        _calendar.headerBackgroundColor = UIColor(red: 61 / 255.0, green: 131 / 255.0, blue: 75 / 255.0, alpha: 1.0)
        _calendar.headerTextColor = UIColor.whiteColor()
        _calendar.headerFont = UIFont.boldSystemFontOfSize(28.0)
        
        _calendar.dayOfWeekFormat = XuniDayOfWeekFormat.D
        _calendar.dayOfWeekBackgroundColor = UIColor(red: 99 / 255.0, green: 166 / 255.0, blue: 70 / 255.0, alpha: 1.0)
        _calendar.dayOfWeekTextColor = UIColor.whiteColor()
        _calendar.dayOfWeekFont = UIFont.boldSystemFontOfSize(20.0)
        
        _calendar.dayBorderColor = UIColor(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        _calendar.dayBorderWidth = 2
        
        _calendar.adjacentDayTextColor = UIColor.grayColor()
        _calendar.calendarFont = UIFont.systemFontOfSize(14.0)
        _calendar.todayFont = UIFont.italicSystemFontOfSize(16.0)

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
        _calendar.frame = CGRectMake(0, 70, width, width - 70)
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
