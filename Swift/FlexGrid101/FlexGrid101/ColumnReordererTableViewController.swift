//
//  ColumnReordererTableViewController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridDynamicKit

class ColumnReordererTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.editing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.parentViewController == nil
        {
            return 0
        }
        let fg: FlexGrid! = (self.parentViewController as! ColumnLayoutController).flex
        if fg == nil
        {
            return 0
        }
        return Int(fg.columns.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath)
        let fg: FlexGrid = (self.parentViewController as! ColumnLayoutController).flex
        let col: GridColumn = fg.columns![Int32(indexPath.row)] as! GridColumn
        cell.textLabel!.text = col.header
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let fg: FlexGrid = (self.parentViewController as! ColumnLayoutController).flex
            fg.columns.removeObjectAtIndex(UInt(indexPath.row))
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        else if editingStyle == .Insert {

        }

    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fg: FlexGrid = (self.parentViewController as! ColumnLayoutController).flex
        let fc: GridColumn = fg.columns![Int32(fromIndexPath.row)] as! GridColumn
        fg.columns.removeObjectAtIndex(UInt(fromIndexPath.row))
        fg.columns.insertObject(fc, atIndex: UInt(toIndexPath.row))
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}
//
//  ColumnReordererTableViewController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//