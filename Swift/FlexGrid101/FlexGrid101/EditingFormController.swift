//
//  EditingFormController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class EditingFormController: UIViewController {
    var edited: CustomerData!

    func cancel() {
        let objEdit: CustomerObjectEditor = (self.childViewControllers[0] as! CustomerObjectEditor)
        objEdit.resignFirstResponder()
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.editpanel.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            self.editpanel.hidden = true
        })
    }

    func confirm() {
        self.flex.collectionView.raiseCollectionChanged()
        self.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = NSMutableArray(array: CustomerData.getCustomerData(100))
        self.flex.flexGridSelectionChanged.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            self.editaction.enabled = true
        }, forObject: self)
        self.flex.flexGridTapped.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            self.cancel()
        }, forObject: self)
        self.flex.flexGridCellDoubleTapped.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            if !self.editpanel.hidden {
                self.cancel()
                return
            }
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.beginEditing()
            })
        }, forObject: self)
        self.flex.autoSizeColumns(0, to: Int32(self.flex.columns.count - 1))
    }

    @IBAction func doedit(sender: AnyObject) {
        self.beginEditing()
    }

    func beginEditing() {
        self.edited = self.flex.collectionView.items![Int(self.flex.selection.row)] as! CustomerData
        let objEdit: CustomerObjectEditor = (self.childViewControllers[0] as! CustomerObjectEditor)
        objEdit.initObject()
        self.editpanel.alpha = 0
        self.editpanel.hidden = false
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.editpanel.alpha = 1
        }, completion: {(finished: Bool) -> Void in
            self.editpanel.alpha = 1
        })
    }

    @IBOutlet weak var editpanel: UIVisualEffectView!
    @IBOutlet weak var flex: FlexGrid!
    @IBOutlet weak var editaction: UIBarButtonItem!
}
//
//  GettingStartedController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//