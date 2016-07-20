//
//  ColumnDefinitionsController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class ColumnDefinitionsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.autoGenerateColumns = false
        let active: GridColumn = GridColumn()
        active.binding = "active"
        active.widthType = GridColumnWidth.Pixel
        active.width = 70
        self.flex.columns.addObject(active)
        let identifier: GridColumn = GridColumn()
        identifier.binding = "customerID"
        identifier.isReadOnly = true
        identifier.widthType = GridColumnWidth.Pixel
        identifier.width = 100
        self.flex.columns.addObject(identifier)
        let firstName: GridColumn = GridColumn()
        firstName.binding = "firstName"
        let lastName: GridColumn = GridColumn()
        lastName.binding = "lastName"
        self.flex.columns.addObject(lastName)
        let orderTotal: GridColumn = GridColumn()
        orderTotal.binding = "orderTotal"
        orderTotal.format = "C2"
        self.flex.columns.addObject(orderTotal)
        let countryID: GridColumn = GridColumn()
        countryID.binding = "countryID"
        countryID.header = "Country"
        countryID.horizontalAlignment = .Left
        let items = CustomerData.defaultCountries()
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
        self.flex.itemsSource = NSMutableArray(array: CustomerData.getCustomerData(100))
        self.flex.isReadOnly = false
    }

    @IBOutlet weak var flex: FlexGrid!
}
//
//  ColumnDefinitionsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//