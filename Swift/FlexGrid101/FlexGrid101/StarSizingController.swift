//
//  StarSizingController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class StarSizingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.autoGenerateColumns = false
        let c1: GridColumn = GridColumn()
        c1.binding = "firstName"
        c1.header = NSLocalizedString("First Name", comment:"")
        c1.widthType = GridColumnWidth.Star
        c1.width = 3
        let c2: GridColumn = GridColumn()
        c2.binding = "lastName"
        c2.header = NSLocalizedString("Last Name", comment:"")
        c2.widthType = GridColumnWidth.Star
        c2.width = 3
        let c3: GridColumn = GridColumn()
        c3.binding = "lastOrderDate"
        c3.header = NSLocalizedString("Last Date", comment:"")
        c3.widthType = GridColumnWidth.Star
        c3.width = 2
        let c4: GridColumn = GridColumn()
        c4.binding = "orderTotal"
        c4.header = NSLocalizedString("Total", comment:"")
        c4.format = "C"
        c4.headerHorizontalAlignment = .Left
        c4.widthType = GridColumnWidth.Star
        c4.width = 2
        self.flex.columns.addObject(c1)
        self.flex.columns.addObject(c2)
        self.flex.columns.addObject(c3)
        self.flex.columns.addObject(c4)
        self.flex.itemsSource = NSMutableArray(array: CustomerData.getCustomerData(100))
        self.flex.isReadOnly = true
    }

    @IBOutlet weak var flex: FlexGrid!
}