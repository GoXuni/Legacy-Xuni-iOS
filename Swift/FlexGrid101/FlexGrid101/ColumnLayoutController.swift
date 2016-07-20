//
//  ColumnLayoutController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class ColumnLayoutController: UIViewController {
    @IBOutlet weak var flex: FlexGrid!
    var editButton: UIBarButtonItem!
    var restoreButton: UIBarButtonItem!
    var columnsInitial: GridColumnCollection!


    override func viewDidLoad() {
        super.viewDidLoad()
        editButton = UIBarButtonItem(title: NSLocalizedString("Edit Columns", comment:""), style: .Plain, target: self, action: #selector(editColumns(_:)))
        restoreButton = UIBarButtonItem(title: NSLocalizedString("Restore", comment:""), style: .Plain, target: self, action: #selector(restoreColumns(_:)))
        self.navigationItem.rightBarButtonItems = [editButton]
        self.columnList.hidden = true
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = NSMutableArray(array: CustomerData.getCustomerData(100))
        columnsInitial = GridColumnCollection()
        for i: UInt in 0 ..< self.flex.columns.count {
            columnsInitial.addObject(self.flex.columns![Int32(i)])
        }
        self.flex.autoSizeColumns(0, to: Int32(self.flex.columns.count - 1))
    }

    func beginEditing() {
        (self.childViewControllers.first as! ColumnReordererTableViewController).tableView.reloadData()
        self.columnList.alpha = 0
        self.columnList.hidden = false
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.columnList.alpha = 1
        }, completion: {(finished: Bool) -> Void in
        })
        editButton.title = NSLocalizedString("Done",comment: "")
        self.navigationItem.rightBarButtonItems = [editButton, restoreButton]
    }

    func endEditing() {
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.columnList.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            self.columnList.hidden = true
        })
        editButton.title = NSLocalizedString("Edit Columns",comment: "")
        self.navigationItem.rightBarButtonItems = [editButton]
    }

    @IBAction func restoreColumns(sender: AnyObject) {
        self.flex.columns.removeAllObjects()
        for i: UInt in 0 ..< columnsInitial.count {
            self.flex.columns.addObject(columnsInitial![Int32(i)])
        }
        (self.childViewControllers.first as! ColumnReordererTableViewController).tableView.reloadData()
    }

    @IBAction func editColumns(sender: AnyObject) {
        if self.columnList.hidden {
            self.beginEditing()
        }
        else {
            self.endEditing()
        }
    }

    @IBOutlet weak var columnList: UIVisualEffectView!
}
//
//  ColumnLayoutController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//