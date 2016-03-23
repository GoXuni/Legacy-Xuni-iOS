import Foundation
import UIKit
import XuniFlexGridKit

class ColumnReordererTableViewController: UITableViewController {

    override func viewDidLoad() {
        columnReorderTable = self
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
        
        if (columnLayoutController == nil) {return 0}
        
        let fg: FlexGrid! = columnLayoutController.flex
        return Int(fg.columns.count)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath)
        let fg: FlexGrid = columnLayoutController.flex
        let col: FlexColumn = fg.columns.objectAtIndex(UInt(indexPath.row)) as! FlexColumn
        cell.textLabel!.text = col.header
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let fg: FlexGrid = columnLayoutController.flex
            fg.columns.removeObjectAtIndex(UInt(indexPath.row))
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        else {
            if editingStyle == .Insert {

            }
        }
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fg: FlexGrid = columnLayoutController.flex
        let fc: FlexColumn = fg.columns.objectAtIndex(UInt(fromIndexPath.row)) as! FlexColumn
        fg.columns.removeObjectAtIndex(UInt(fromIndexPath.row))
        fg.columns.insertObject(fc, atIndex: UInt(toIndexPath.row))
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}


var columnReorderTable: ColumnReordererTableViewController! = nil
