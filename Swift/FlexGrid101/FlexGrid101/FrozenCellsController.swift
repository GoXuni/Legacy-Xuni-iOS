//
//  FrozenCellsController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class FrozenCellsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
        self.flex.frozenColumns = 1
        self.flex.frozenRows = 1
        self.flex.allowMerging = GridAllowMerging.Cells
        for i:UInt in 0 ..< self.flex.columns.count {
            let fc: GridColumn = self.flex.columns![Int32(i)] as! GridColumn
            if (fc.binding == "country") {
                fc.allowMerging = true
            }
        }
        self.flex.autoSizeColumns(0, to: Int32(self.flex.columns.count - 1))
    }

    @IBOutlet weak var flex: FlexGrid!
}
//
//  FrozenCellsController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//