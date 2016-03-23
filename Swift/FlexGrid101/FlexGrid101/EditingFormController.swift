import Foundation
import UIKit
import XuniFlexGridKit

class EditingFormController: UIViewController, FlexGridDelegate {
    

    @IBOutlet weak var editpanel: UIVisualEffectView!
    
    var flex: FlexGrid! = nil;
    
    func cancel() {
        objEdit.resignFirstResponder()
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.editpanel.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            self.editpanel.hidden = true
        })
    }

    func confirm() {
        flex.collectionView.raiseCollectionChanged()
        cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        efc = self
        flex = FlexGrid()
        flex.columnHeaderFont = UIFont.boldSystemFontOfSize(flex.columnHeaderFont.pointSize)
        flex.isReadOnly = true
        flex.delegate = self
        flex.itemsSource = CustomerData.getCustomerData(100)
        flex.tag = 1
        flex.autoSizeColumns(0, to: Int32(flex.columns.count) - 1)
        view.addSubview(flex)
        view.sendSubviewToBack(flex)
    }

    func tapped(sender: FlexGrid!, point: XuniPoint!) -> Bool {
        cancel()
        return false
    }
    
    func cellDoubleTapped(sender: FlexGrid!, panel: FlexGridPanel!, forRange range: FlexCellRange!) -> Bool {
        if !editpanel.hidden {
            tapped(nil, point: nil)
            return false
        }
        edited = flex.itemsSource.objectAtIndex(Int(range.row)) as! CustomerData
        objEdit.initObject()
        self.editpanel.alpha = 0
        self.editpanel.hidden = false
        UIView.animateWithDuration(0.7, animations: {() -> Void in
            self.editpanel.alpha = 1
        }, completion: {(finished: Bool) -> Void in
            self.editpanel.alpha = 1
        })
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (self.navigationController == nil) {return;}
        let ss: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height + navigationController!.navigationBar.intrinsicContentSize().height
        flex.frame = CGRectMake(0, ss, view.bounds.size.width, view.bounds.size.height - ss)
        flex.setNeedsDisplay()
    }
}

var efc: EditingFormController! = nil

var edited: CustomerData! = nil
