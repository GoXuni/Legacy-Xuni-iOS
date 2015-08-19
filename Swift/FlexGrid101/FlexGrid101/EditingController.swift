//
//  EditingController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexGridKit

class EditingController: UIViewController, FlexGridDelegate  {

    var _flex = FlexGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _flex.isReadOnly = false
        _flex.delegate = self;
        _flex.headersVisibility = FlexHeadersVisibility.Column
        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.columns.removeObjectAtIndex(1)
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
    func prepareCellForEdit(args: FlexCellRangeEventArgs!) {
        var col = _flex.columns.objectAtIndex(UInt(args.col)) as! FlexColumn
        if(col.binding == "hireDate")
        {
            var editor =  _flex.activeEditor as! UITextField
            var picker = UIDatePicker()
            var d = _flex.cells.getCellDataForRow(args.row, inColumn: args.col, formatted: false) as! NSDate
            picker.opaque = true
            picker.datePickerMode = UIDatePickerMode.Date
            picker.date = d
            picker.addTarget(self, action: "onDatePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
            editor.inputView = picker
            var toolbar = UIToolbar(frame: CGRectMake(0, 0, _flex.frame.size.width, 44))
            toolbar.barStyle = UIBarStyle.Default
            var done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "endEditDatePicker:")
            var space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            toolbar.setItems([space, done], animated: true)
            editor.inputAccessoryView = toolbar
            editor.clearButtonMode = UITextFieldViewMode.Never
        }
    }
    func onDatePickerChanged(sender : UIDatePicker){
        var editor = _flex.activeEditor as! UITextField
        var c = _flex.columns.objectAtIndex(UInt(_flex.editRange.col)) as! FlexColumn
        editor.text = c.getFormattedValue(sender.date) as! String
    }
    func endEditDatePicker(textField : UITextField)-> Bool{
        var editor = _flex.activeEditor as! UITextField
        var picker = editor.inputView as! UIDatePicker
        _flex.cells.setCellData(picker.date, forRow: _flex.editRange.row, inColumn: _flex.editRange.col)
        _flex.finishEditing(true)
        return true
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
