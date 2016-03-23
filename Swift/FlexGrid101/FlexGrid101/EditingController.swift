//
//  EditingController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

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
    
    func prepareCellForEdit(sender: FlexGrid!, panel: FlexGridPanel!, forRange range: FlexCellRange!) -> Bool
    {
        let col = _flex.columns.objectAtIndex(UInt(range.col)) as! FlexColumn
        if(col.binding == "hireDate")
        {
            let editor =  _flex.activeEditor as! UITextField
            let picker = UIDatePicker()
            let d = _flex.cells.getCellDataForRow(range.row, inColumn: range.col, formatted: false) as! NSDate
            picker.opaque = true
            picker.datePickerMode = UIDatePickerMode.Date
            picker.date = d
            picker.addTarget(self, action: "onDatePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
            editor.inputView = picker
            let toolbar = UIToolbar(frame: CGRectMake(0, 0, _flex.frame.size.width, 44))
            toolbar.barStyle = UIBarStyle.Default
            let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "endEditDatePicker:")
            let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            toolbar.setItems([space, done], animated: true)
            editor.inputAccessoryView = toolbar
            editor.clearButtonMode = UITextFieldViewMode.Never
        }
        return false
    }
    func onDatePickerChanged(sender : UIDatePicker){
        let editor = _flex.activeEditor as! UITextField
        let c = _flex.columns.objectAtIndex(UInt(_flex.editRange.col)) as! FlexColumn
        editor.text = (c.getFormattedValue(sender.date) as! String)
    }
    func endEditDatePicker(textField : UITextField)-> Bool{
        let editor = _flex.activeEditor as! UITextField
        let picker = editor.inputView as! UIDatePicker
        _flex.cells.setCellData(picker.date, forRow: _flex.editRange.row, inColumn: _flex.editRange.col)
        _flex.finishEditing(true)
        return true
    }

}
