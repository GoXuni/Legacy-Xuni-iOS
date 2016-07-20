//
//  FullTextFilterController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit

class FullTextFilterController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterField.returnKeyType = UIReturnKeyType.Done
        
        self.filterField.keyboardType = .Default
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
        
        self.flex.flexGridFormatItem.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridFormatItemEventArgs
            if eventContainerEventArgs.panel == self.flex.cells {
                if !(self.flex.editRange==nil) && self.flex.editRange.intersects(eventContainerEventArgs.cellRange) {
                    return
                }
                
                if (self.flex.columns![eventContainerEventArgs.col] as! GridColumn).dataType == XuniDataType.Boolean
                {
                    return
                }
                
                do
                {
                    
                    let regex: NSRegularExpression = try NSRegularExpression(pattern: self.filterField.text!, options: NSRegularExpressionOptions.CaseInsensitive)
                    let data: String = self.flex.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: true).description
                    
                    let attributedString: NSMutableAttributedString = NSMutableAttributedString(string:data)
                    let allMatches = regex.matchesInString(data, options: NSMatchingOptions(), range: NSMakeRange(0, data.characters.count))
                    for aMatch: NSTextCheckingResult in allMatches {
                        let matchRange: NSRange = aMatch.range
                        attributedString.setAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(self.flex.font.pointSize), NSForegroundColorAttributeName: UIColor.redColor()], range: matchRange)
                    }
                    
                    var t: CGRect = eventContainerEventArgs.panel.getCellRectForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col)
                    let col: GridColumn = self.flex.columns![eventContainerEventArgs.col] as! GridColumn
                    let sz: CGSize = attributedString.size()
                    let align: NSTextAlignment = col.horizontalAlignment
                    if align == .Right {
                        var mod = t.size.width - sz.width - 4
                        if mod < 4 {
                            mod = 4
                        }
                        t.origin.x += mod
                    }
                    else if align == .Center {
                        var mod = (t.size.width - sz.width) / 2
                        if mod < 4 {
                            mod = 4
                        }
                        t.origin.x += mod
                    }
                    else {
                        t.origin.x += 4
                    }
                    
                    var mod = (t.size.height - sz.height) / 2
                    if mod < 4 {
                        mod = 4
                    }
                    t.origin.y += mod
                    attributedString.drawInRect(t)
                    eventContainerEventArgs.cancel = true
                }
                catch
                {
                    
                }
                
            }
            }, forObject: self)
    }
    
    @IBAction func onTextChange(sender: UITextField) {
        let textField: UITextField = sender
        let flex: FlexGrid = self.flex
        let dateFormat: NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "M/d/yy"
        if textField.text?.characters.count > 0 {
            flex.collectionView.filter = {(item: NSObject!) -> Bool in
                let d: CustomerData = (item as! CustomerData)
                if "\(d.customerID)".lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if "\(d.countryID)".lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if "\(d.email)".lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if d.firstName.lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if d.lastName.lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if d.country.lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if d.city.lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if d.address.lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else if dateFormat.stringFromDate(d.lastOrderDate).lowercaseString.containsString(textField.text!.lowercaseString) {
                    return true
                }
                else {
                    return false
                }
                
            }
        }
        else {
            flex.collectionView.filter = nil
        }
    }
    
    @IBAction func finishedit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBOutlet weak var filterField: UITextField!
    @IBOutlet weak var flex: FlexGrid!
}
//
//  FullTextFilterController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//