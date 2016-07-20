//
//  GroupingController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class GroupingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.autoGenerateColumns = false
        let c1: GridColumn = GridColumn()
        c1.binding = "active"
        c1.header = NSLocalizedString("Active", comment: "")
        c1.width = 100
        let c2: GridColumn = GridColumn()
        c2.binding = "firstName"
        c2.header = NSLocalizedString("Name", comment: "")
        let c3: GridColumn = GridColumn()
        c3.binding = "orderTotal"
        c3.header = NSLocalizedString("Order Total", comment: "")
        c3.format = "C"
        c3.aggregate = XuniAggregate.Sum
        self.flex.columns.addObject(c1)
        self.flex.columns.addObject(c2)
        self.flex.columns.addObject(c3)
        let gd: XuniPropertyGroupDescription = XuniPropertyGroupDescription(property: "country")
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
        self.flex.collectionView.groupDescriptions.addObject(gd)
        self.starSizing(self.flex)
    }

    func starSizing(g: FlexGrid) {
        for i:UInt in 0 ..< g.columns.count {
            let c: GridColumn = g.columns.objectAtIndex(i) as! GridColumn
            c.widthType = GridColumnWidth.Star
            c.width = (i == 0) ? 2 : (i == 3) ? 3 : 4
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doSort(sender: AnyObject) {
        let btn: UIBarButtonItem = (sender as! UIBarButtonItem)
        if (btn.title == NSLocalizedString("Z-A", comment:"")) {
            self.sortDescendingButtonClicked()
            btn.title = NSLocalizedString("A-Z", comment:"")
        }
        else {
            self.sortAscendingButtonClicked()
            btn.title = NSLocalizedString("Z-A", comment:"")
        }
    }

    @IBAction func doCollapse(sender: AnyObject) {
        let btn: UIBarButtonItem = (sender as! UIBarButtonItem)
        if (btn.title == NSLocalizedString("Collapse", comment:"")) {
            self.flex.collapseGroupsToLevel(0)
            btn.title = NSLocalizedString("Expand", comment:"")
        }
        else {
            if self.flex.finishEditing(false) {
                for i:UInt in 0 ..< self.flex.rows.count {
                    let row: GridRow = (self.flex.rows.objectAtIndex(i) as! GridRow)
                    if (row is GridGroupRow) {
                        let group: GridGroupRow = (row as! GridGroupRow)
                        group.isCollapsed = false
                    }
                }
            }
            btn.title = NSLocalizedString("Collapse", comment:"")
        }
    }

    func sortAscendingButtonClicked() {
        self.flex.collectionView.sortDescriptions.removeAllObjects()
        let sd: XuniSortDescription = XuniSortDescription(property: "country", ascending: true)
        self.flex.collectionView.sortDescriptions.addObject(sd)
        self.collapseButton.title = NSLocalizedString("Collapse", comment:"")
    }

    func sortDescendingButtonClicked() {
        self.flex.collectionView.sortDescriptions.removeAllObjects()
        let sd: XuniSortDescription = XuniSortDescription(property: "country", ascending: false)
        self.flex.collectionView.sortDescriptions.addObject(sd)
        self.collapseButton.title = NSLocalizedString("Collapse", comment:"")
    }

    @IBOutlet weak var flex: FlexGrid!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var collapseButton: UIBarButtonItem!
}
//
//  GroupingController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//