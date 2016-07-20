//
//  EditingController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class GettingStartedController: UIViewController, FlexGridDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = false
        self.flex.delegate = self
        self.flex.flexGridAutoGeneratingColumn.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridAutoGeneratingColumnEventArgs
            if (eventContainerEventArgs.propertyInfo.name == "country") || (eventContainerEventArgs.propertyInfo.name == "name") || (eventContainerEventArgs.propertyInfo.name == "orderAverage") {
                eventContainerEventArgs.cancel = true
            }
            else if (eventContainerEventArgs.propertyInfo.name == "customerID") {
                eventContainerEventArgs.column.isReadOnly = true
            }
            else if (eventContainerEventArgs.propertyInfo.name == "countryID") {
                eventContainerEventArgs.column.header = "Country"
                eventContainerEventArgs.column.horizontalAlignment = .Left
                let items = CustomerData.defaultCountries()
                eventContainerEventArgs.column.dataMap = GridDataMap(array: items, selectedValuePath: "identifier", displayMemberPath: "title")
            }
            else if (eventContainerEventArgs.propertyInfo.name == "orderTotal") {
                eventContainerEventArgs.column.format = "C2"
            }
            else if (eventContainerEventArgs.propertyInfo.name == "address") {
                eventContainerEventArgs.column.wordWrap = true
            }

        }, forObject: self)
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func prepareCellForEdit(sender: FlexGrid, panel: GridPanel, forRange range: GridCellRange) -> Bool {
        let flex: FlexGrid = self.flex
        let col: GridColumn = flex.columns![range.col] as! GridColumn
        if (col.binding == "lastOrderDate") {
            let editor: UITextField = (flex.activeEditor as! UITextField)
            let picker: UIDatePicker = UIDatePicker()
            let d: NSDate = (flex.cells.getCellDataForRow(range.row, inColumn: range.col, formatted: false) as! NSDate)
            picker.opaque = true
            picker.datePickerMode = .Date
            picker.date = d
            picker.addTarget(self, action: #selector(onDatePickerChanged(_:)), forControlEvents: .ValueChanged)
            editor.inputView = picker
            let toolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, flex.frame.size.width, 44))
            toolbar.barStyle = .Default
            let done: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(endEditDatePicker(_:)))
            let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            toolbar.items = [space, done]
            editor.inputAccessoryView = toolbar
            editor.clearButtonMode = .Never
        }
        return false
    }

    func onDatePickerChanged(sender: UIDatePicker) {
        let flex: FlexGrid = self.flex
        let editor: UITextField = (flex.activeEditor as! UITextField)
        let c: GridColumn = flex.columns![flex.editRange.col] as! GridColumn
        editor.text = String(c.getFormattedValue(sender.date))
    }

    func endEditDatePicker(textField: UITextField) -> Bool {
        let flex: FlexGrid = self.flex
        let editor: UITextField = (flex.activeEditor as! UITextField)
        let picker: UIDatePicker = (editor.inputView as! UIDatePicker)
        flex.cells.setCellData(picker.date, forRow: flex.editRange.row, inColumn: flex.editRange.col)
        flex.finishEditing(true)
        return true
    }

    @IBOutlet weak var flex: FlexGrid!
}
//
//  EditingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//