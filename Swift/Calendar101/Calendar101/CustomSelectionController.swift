//
//  CustomSelectionController.swift
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniCalendarKit

class CustomSelectionController: UIViewController, XuniCalendarDelegate {

    var _calendar = XuniCalendar(frame: CGRectZero)
    var _stepsLabel = UILabel()
    var _components = NSDateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom Selection"

        // Do any additional setup after loading the view.
        _stepsLabel.numberOfLines = 3
        _stepsLabel.text = "Step1: Select a date.\nStep2: Select another date in a different week.\nObserve: The weekend days are not selected."
        
        _calendar.delegate = self
        _calendar.maxSelectionCount = -1
        
        self.view.addSubview(_stepsLabel)
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
        _stepsLabel.frame = CGRectMake(0, 55, width, 100)
        _calendar.frame = CGRectMake(0, 55 + 100, width, width - 55 - 100)
    }
    
    func selectionChanging(sender: XuniCalendar, args: XuniCalendarSelectionChangedEventArgs) {
        for (var date = args.selectedDates.startDate;
            date.compare(args.selectedDates.endDate) == NSComparisonResult.OrderedAscending
            || date.compare(args.selectedDates.endDate) == NSComparisonResult.OrderedSame;
        date = getNextDateOf(date)) {
            
            let weekday = NSCalendar.currentCalendar().components(NSCalendarUnit.Weekday, fromDate: date).weekday
            if (weekday == 1 || weekday == 7) {
                args.selectedDates.addExcludedDates(date)
            }
        }
    }
    
    func getNextDateOf(date: NSDate) -> NSDate {
        _components.setValue(1, forComponent: NSCalendarUnit.Day)
        return NSCalendar.currentCalendar().dateByAddingComponents(_components, toDate: date, options: NSCalendarOptions.MatchFirst)!
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
