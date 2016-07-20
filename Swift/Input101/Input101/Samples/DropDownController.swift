//
//  DropDownController.swift
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

import Foundation
import XuniInputKit
import XuniCalendarKit

class DropDownController: UIViewController,XuniDropDownDelegate,XuniCalendarDelegate {
    @IBOutlet weak var dropdown: XuniDropDown!
    
    var _field:        XuniMaskedTextField?
    var _dropdownView: XuniDropDownView?
    var _calendar:     XuniCalendar?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DropDown"
        
        dropdown.delegate = self
        dropdown.buttonColor = UIColor.lightGrayColor()
        dropdown.dropDownHeight = 300
        dropdown.dropDownWidth = (Double)(dropdown.frame.size.width + 30.0)
        dropdown.dropDownDirection = XuniDropDownDirection.BelowOrAbove
        dropdown.isAnimated = true
        
        _field = XuniMaskedTextField.init()
        _field!.mask = "00/00/0000"
        _field!.borderStyle = UITextBorderStyle.None
        dropdown.header = _field
        
        _calendar = XuniCalendar.init()
        _calendar?.disabledTextColor = UIColor.yellowColor()
        _calendar?.delegate = self
        dropdown.dropDownView = _calendar
    }
    
    
    func selectionChanged(sender:XuniCalendar,selectedDates:XuniCalendarRange)
    {
         let _dateFormatter = NSDateFormatter()
        _dateFormatter.dateFormat = "MM/dd/yyyy"
        _field!.text = _dateFormatter.stringFromDate((sender).selectedDate)
        dropdown.isDropDownOpen = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}