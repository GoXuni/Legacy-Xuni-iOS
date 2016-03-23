//
//  CustomDayContentController.swift
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniCalendarKit

class CustomDayContentController: UIViewController, XuniCalendarDelegate {

    let weatherIcon = [
        "sunny",
        "cloudy",
        "rainy",
        "stomy"]
    
    let dotIcon = [
        "blue",
        "red",
        "green"]
    
    var _calendar = XuniCalendar(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom Day Content"

        // Do any additional setup after loading the view.
        _calendar.delegate = self
        _calendar.dayOfWeekFormat = XuniDayOfWeekFormat.DDDD
        _calendar.calendarFont = UIFont.systemFontOfSize(14)
        _calendar.todayFont = UIFont.boldSystemFontOfSize(14)
        
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

    func dayOfWeekSlotLoading(sender: XuniCalendar, args: XuniCalendarDayOfWeekSlotLoadingEventArgs) {
        args.dayOfWeekSlot.font = args.isWeekend ? UIFont.italicSystemFontOfSize(11.0) : UIFont.boldSystemFontOfSize(11.0)
    }
    
    func daySlotLoading(sender: XuniCalendar, args: XuniCalendarDaySlotLoadingEventArgs) {
        if (args.isAdjacentDay) {
            return;
        }
        
        let day = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: args.date).day
        let rect = args.daySlot.frame
        let size = rect.size
        var rect1: CGRect
        var rect2: CGRect
        let imageDaySlot = XuniCalendarImageDaySlot(calendar: sender, frame: rect)
        
        if (day >= 14 && day <= 23) {
            rect1 = CGRectMake(0, 0, size.height / 4, size.height / 4)
            rect2 = CGRectMake(size.width / 4, size.height / 5 * 2, size.width / 2, size.height / 2)
            
            imageDaySlot.dayTextRect = rect1
            imageDaySlot.dayFont = UIFont.systemFontOfSize(9.0)
            imageDaySlot.imageRect = rect2
            imageDaySlot.imageSource = UIImage(named: weatherIcon[day % 4])
        }
        else {
            rect1 = CGRectMake(0, 0, size.width, size.height / 6 * 4)
            rect2 = CGRectMake(size.width / 2 - 6 / 2, size.height / 6 * 4, 6, 6)
            
            imageDaySlot.dayTextRect = rect1
            imageDaySlot.imageRect = rect2
            imageDaySlot.imageSource = UIImage(named: dotIcon[day % 3])
        }
        
        args.daySlot = imageDaySlot
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
