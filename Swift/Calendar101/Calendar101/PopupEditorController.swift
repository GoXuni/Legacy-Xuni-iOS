//
//  PopupEditorController.swift
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniCalendarKit

class PopupEditorController: UIViewController, XuniCalendarDelegate {

    var _dateFormatter = NSDateFormatter()
    var _calendar = XuniCalendar(frame: CGRectZero)
    var _pickBtn = UIButton(type: UIButtonType.System)
    var _dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popup Editor"

        // Do any additional setup after loading the view.
        _calendar.delegate = self
        _calendar.hidden = true
        
        _pickBtn.setTitle("Pick a date", forState: UIControlState.Normal)
        _pickBtn.addTarget(self, action: "pickBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        _dateLabel.text = ""
        
        self.view.addSubview(_pickBtn)
        self.view.addSubview(_dateLabel)
        self.view.addSubview(_calendar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = self.view.bounds.size
        let width = min(size.width, size.height) / 3 * 2
        
        _pickBtn.frame = CGRectMake(10, 55 + 10, size.width - 10 - 10, 30)
        _dateLabel.frame = CGRectMake((size.width - 280) / 2, 55 + 50, 280, 30)
        _calendar.frame = CGRectMake((size.width - width) / 2, 55 + 140, width, width)
    }
    
    func pickBtnClick(sender: UIButton) {
        _calendar.hidden = !_calendar.hidden
    }

    func selectionChanged(sender: XuniCalendar, args: XuniCalendarSelectionChangedEventArgs) {
        _dateFormatter.dateFormat = "M/d/yyyy"
        _dateLabel.text = String(format: "The date %@ was selected.", _dateFormatter.stringFromDate(args.selectedDates.startDate))
        _calendar.hidden = true
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
