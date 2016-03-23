import Foundation
import UIKit
import XuniFlexGridKit

class ColumnLayoutController: UIViewController {
    var flex: FlexGrid! = nil
    var editButton: UIBarButtonItem! = nil

    override func viewDidLoad() {
        columnLayoutController = self
        super.viewDidLoad()
        editButton = UIBarButtonItem(title: NSLocalizedString("Edit Columns", comment: ""), style: .Plain, target: self,
            action: "editColumns:")
        self.navigationItem.rightBarButtonItem = editButton
        self.columnList.hidden = true
        self.flex = FlexGrid()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.itemsSource = CustomerData.getCustomerData(100)
        self.flex.tag = 1
        flex.autoSizeColumns(0, to: Int32(flex.columns.count) - 1)
        view.addSubview(flex)
        view.sendSubviewToBack(flex)
    }

    func beginEditing() {
        columnReorderTable.tableView.reloadData()
        self.columnList.alpha = 0
        self.columnList.hidden = false
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.columnList.alpha = 1
        }, completion: {(finished: Bool) -> Void in
        })
        editButton.title = NSLocalizedString("Done", comment: "")
    }

    @IBOutlet weak var columnList: UIVisualEffectView!
    
    func endEditing() {
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.columnList.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            self.columnList.hidden = true
        })
        editButton.title = NSLocalizedString("Edit Columns", comment: "")
    }

    @IBAction func editColumns(sender: AnyObject) {
        if columnList.hidden {
            beginEditing()
        }
        else {
            endEditing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.navigationController == nil) {return;}
        
        let ss: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height + navigationController!.navigationBar.intrinsicContentSize().height
        self.flex.frame = CGRectMake(0, ss, view.bounds.size.width, view.bounds.size.height - ss)
        flex.setNeedsDisplay()
    }
}

var columnLayoutController: ColumnLayoutController! = nil