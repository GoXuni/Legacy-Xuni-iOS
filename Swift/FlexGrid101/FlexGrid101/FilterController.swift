//
//  FilterController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class FilterController: UIViewController {
    @IBOutlet weak var flex: FlexGrid!

    func doDropFilter() {
        self.filterButton.title = NSLocalizedString("Filter", comment:"")
        self.removeFilterButton.enabled = false
        self.filterPane.hidden = true
        
        self.flex.collectionView.filter = {(item: NSObject!) -> Bool in
            return true
        }
    }

    func doApplyFilter() {
        self.filterButton.title = NSLocalizedString("Change", comment:"")
        self.filterPane.hidden = true
        self.removeFilterButton.enabled = true
        self.flex.collectionView.filter = {(item: NSObject!) -> Bool in
            let shared = FilterData.sharedFilterData()
            var result: Bool = true
            for i in 0 ..< shared.count {
                
                let fd: FilterData = shared[i] as! FilterData
                
                let col: GridColumn = (self.flex.columns![Int32(i)] as! GridColumn)
                let thisprop: String = col.getBoundValue(item).description.lowercaseString
                if fd.filterString == nil
                {
                    continue
                }
                let filterstr: String = fd.filterString.lowercaseString
                print(filterstr)
                if filterstr.characters.count > 0 {
                    if fd.filterOperation == 0 {
                        //contains
                        if !thisprop.containsString(filterstr) {
                            result = false
                        }
                    }
                    else if fd.filterOperation == 1 {
                        //starts
                        if !thisprop.hasPrefix(filterstr) {
                            result = false
                        }
                    }
                    else if fd.filterOperation == 2 {
                        //ends
                        if !thisprop.hasSuffix(filterstr) {
                            result = false
                        }
                    }
                    else if fd.filterOperation == 3 {
                        //equalstext
                        if !(thisprop == filterstr) {
                            result = false
                        }
                    }
                }
            }
            return result
        }
    }

    func doStartEditingFilter() {
        if (self.filterButton.title == NSLocalizedString("Filter", comment:"")) {
            let shared = FilterData.sharedFilterData()
            shared.removeAllObjects()
            for i:UInt in 0 ..< self.flex.columns.count {
                let c: GridColumn = self.flex.columns![Int32(i)] as! GridColumn
                let fd: FilterData = FilterData()
                fd.filterColumn = c.header
                fd.filterOperation = 0
                fd.filterString = nil
                shared.addObject(fd)
            }
        }
        let filterController: FilterGridViewController = (self.childViewControllers.first as! FilterGridViewController)
        filterController.flex.itemsSource = FilterData.sharedFilterData()
        let operID: GridColumn = (filterController.flex.columns[1] as! GridColumn)
        let items = FilterOperation.defaultOperations()
        operID.dataMap = GridDataMap(array: items, selectedValuePath: "identifier", displayMemberPath: "title")
        self.filterButton.title = NSLocalizedString("Done", comment: "")
        self.filterPane.hidden = false
        self.removeFilterButton.enabled = true
    }

    @IBAction func doFilter(sender: AnyObject) {
        if (self.filterButton.title == NSLocalizedString("Done", comment: "")) {
            self.doApplyFilter()
        }
        else {
            self.doStartEditingFilter()
        }
    }

    @IBAction func removeFilter(sender: AnyObject) {
        self.doDropFilter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
    }

    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var removeFilterButton: UIBarButtonItem!
    @IBOutlet weak var filterPane: UIVisualEffectView!
}
//
//  FilterController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//