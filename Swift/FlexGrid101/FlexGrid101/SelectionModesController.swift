//
//  SelectionModesController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class SelectionModesController: UIViewController {

    @IBAction func modeSwitched(sender: AnyObject) {
        let row: Int = self.modeSwitch.selectedSegmentIndex
        if row == 0 {
            self.flex.selectionMode = GridSelectionMode.None
        }
        else if row == 1 {
            self.flex.selectionMode = GridSelectionMode.Cell
        }
        else if row == 2 {
            self.flex.selectionMode = GridSelectionMode.CellRange
        }
        else if row == 3 {
            self.flex.selectionMode = GridSelectionMode.Row
        }
        else if row == 4 {
            self.flex.selectionMode = GridSelectionMode.RowRange
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.isReadOnly = true
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.selectionMode = GridSelectionMode.None
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
        self.flex.flexGridSelectionChanged.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let selected = self.flex.selection.columnSpan * self.flex.selection.rowSpan
            self.selectedCount.title = "\(selected) selected"
        }, forObject: self)
    }

    @IBOutlet weak var flex: FlexGrid!
    @IBOutlet weak var modeSwitch: UISegmentedControl!
    @IBOutlet weak var selected: UIBarButtonItem!
    @IBOutlet weak var selectedCount: UIBarButtonItem!
}
//
//  SelectionModesController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//