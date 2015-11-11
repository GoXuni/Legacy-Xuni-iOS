//
//  EditConfirmationController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class EditConfirmationController: UIViewController, FlexGridDelegate {

    var _flex = FlexGrid()
    var _temp = NSObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _flex.isReadOnly = false
        _flex.delegate = self
        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.columns.removeObjectAtIndex(1)
        self.view.addSubview(_flex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _flex.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65)
        _flex.setNeedsDisplay()
    }
    func beginningEdit(args: FlexCellRangeEventArgs!) {
        _temp = _flex.cells.getCellDataForRow(args.row, inColumn: args.col, formatted: false)
    }
    
    func cellEditEnding(args: FlexCellRangeEventArgs!) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            if(self._flex.cells.getCellDataForRow(args.row, inColumn: args.col, formatted: false).isEqual(self._temp))
            {
                return;
            }
            
            let title = "Edit Confirmation"
            let message = "Do you want to commit the edit?"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) -> Void in
                self._flex.cells.setCellData(self._temp, forRow: args.row, inColumn: args.col)
                self._flex.invalidate()
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
