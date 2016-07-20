//
//  EditConfirmationController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class EditConfirmationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.isReadOnly = false
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.autoGenerateColumns = false
        let identifier: GridColumn = GridColumn()
        identifier.binding = "customerID"
        identifier.isReadOnly = true
        identifier.widthType = GridColumnWidth.Pixel
        identifier.width = 100
        self.flex.columns.addObject(identifier)
        let firstName: GridColumn = GridColumn()
        firstName.binding = "firstName"
        self.flex.columns.addObject(firstName)
        let lastName: GridColumn = GridColumn()
        lastName.binding = "lastName"
        self.flex.columns.addObject(lastName)
        let address: GridColumn = GridColumn()
        address.binding = "address"
        self.flex.columns.addObject(address)
        let city: GridColumn = GridColumn()
        city.binding = "city"
        self.flex.columns.addObject(city)
        let postalCode: GridColumn = GridColumn()
        postalCode.binding = "postalCode"
        self.flex.columns.addObject(postalCode)
        let active: GridColumn = GridColumn()
        active.binding = "active"
        active.widthType = GridColumnWidth.Pixel
        active.width = 70
        self.flex.columns.addObject(active)
        
        
        self.flex.itemsSource = NSMutableArray(array: CustomerData.getCustomerData(100))
        
        self.flex.flexGridCellEditEnding.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs : GridCellRangeEventArgs = eventContainer.eventArgs as! GridCellRangeEventArgs
            
            var activeEditorValue: NSObject! = self.flex.activeEditorValue
            if activeEditorValue == nil {
                activeEditorValue = ""
            }
            if self.flex.cells.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: false).isEqual(activeEditorValue) {
                eventContainerEventArgs.cancel = true
                return
            }
            let prev: NSObject = self.flex.cells.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: false)
            var title: String = String()
            var message: String = String()
            title = NSLocalizedString("Edit Confirmation", comment: "")
            message = NSLocalizedString("Do you want to commit the edit?", comment: "")
            let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .Default, handler: {(action: UIAlertAction) -> Void in
                })
            let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: {(action: UIAlertAction) -> Void in
                    self.flex.cells.setCellData(prev, forRow: eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col)
                })
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: { _ in })
            eventContainerEventArgs.cancel = false
        }, forObject: self)
    }

    @IBOutlet weak var flex: FlexGrid!
}
//
//  EditConfirmationController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//