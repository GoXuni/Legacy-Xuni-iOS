//
//  ConditionalFormattingController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class ConditionalFormattingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.autoGenerateColumns = false
        let c1: GridColumn = GridColumn()
        c1.binding = "firstName"
        c1.header = NSLocalizedString("First Name", comment:"")
        c1.width = 100
        let c2: GridColumn = GridColumn()
        c2.binding = "lastName"
        c2.header = NSLocalizedString("Last Name", comment:"")
        let c3: GridColumn = GridColumn()
        c3.binding = "orderTotal"
        c3.header = NSLocalizedString("Total", comment:"")
        c3.format = "C"
        let c4: GridColumn = GridColumn()
        c4.binding = "orderCount"
        c4.header = NSLocalizedString("Count", comment:"")
        c4.format = "N1"
        self.flex.columns.addObject(c1)
        self.flex.columns.addObject(c2)
        self.flex.columns.addObject(c3)
        self.flex.columns.addObject(c4)
        let countryID: GridColumn = GridColumn()
        countryID.binding = "countryID"
        countryID.header = "Country"
        countryID.horizontalAlignment = .Left
        let items = (array: CustomerData.defaultCountries())
        countryID.dataMap = GridDataMap(array: items, selectedValuePath: "identifier", displayMemberPath: "title")
        self.flex.columns.addObject(countryID)
        let lastOrderDate: GridColumn = GridColumn()
        lastOrderDate.binding = "lastOrderDate"
        self.flex.columns.addObject(lastOrderDate)
        let lastOrderTime: GridColumn = GridColumn()
        lastOrderTime.binding = "lastOrderDate"
        lastOrderTime.header = "Last Order Time"
        let datefmt: NSDateFormatter = NSDateFormatter()
        datefmt.dateFormat = "hh:mm a"
        lastOrderTime.formatter = datefmt
        self.flex.columns.addObject(lastOrderTime)
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
        self.flex.flexGridFormatItem.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridFormatItemEventArgs
            if eventContainerEventArgs.panel.cellType == GridCellType.Cell {
                let g: FlexGrid! = self.flex
                let col: GridColumn = g.columns![eventContainerEventArgs.col] as! GridColumn
                if (col.binding == "orderCount") {
                    let n: NSNumber! = eventContainerEventArgs.panel.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: false) as! NSNumber!
                    if n != nil {
                        if n.integerValue >= 50 {
                            let r: CGRect = eventContainerEventArgs.panel.getCellRectForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col)
                            CGContextSetFillColorWithColor(eventContainerEventArgs.context, UIColor(red: 0.15, green: 0.31, blue: 0.07, alpha: 1.0).CGColor)
                            CGContextFillRect(eventContainerEventArgs.context, r)
                        }
                        else if n.integerValue < 50 {
                            let r: CGRect = eventContainerEventArgs.panel.getCellRectForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col)
                            CGContextSetFillColorWithColor(eventContainerEventArgs.context, UIColor.redColor().CGColor)
                            CGContextFillRect(eventContainerEventArgs.context, r)
                        }

                        eventContainerEventArgs.panel.textAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
                    }
                }
                if (col.binding == "orderTotal") {
                    let n: NSNumber! = eventContainerEventArgs.panel.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: false) as! NSNumber!
                    if n != nil {
                        if n.integerValue >= 5000 {
                            eventContainerEventArgs.panel.textAttributes[NSForegroundColorAttributeName] = UIColor(red: 0.15, green: 0.31, blue: 0.07, alpha: 1.0)
                        }
                        else if n.integerValue < 5000 {
                            eventContainerEventArgs.panel.textAttributes[NSForegroundColorAttributeName] = UIColor.redColor()
                        }
                    }
                }
            }
            eventContainerEventArgs.cancel = false
        }, forObject: self)
    }

    @IBOutlet weak var flex: FlexGrid!
}
//
//  ConditionalFormattingController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//