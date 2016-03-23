import Foundation
import UIKit
import XuniFlexGridKit

class OnDemandController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let flex: FlexGrid = FlexGrid()
        flex.columnHeaderFont = UIFont.boldSystemFontOfSize(flex.columnHeaderFont.pointSize)
        flex.isReadOnly = true
        flex.collectionView = DemoCursorCollectionView()
        flex.tag = 1
        flex.autoSizeColumns(0, to: Int32(flex.columns.count) - 1)
        view.addSubview(flex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (self.navigationController == nil) {return;}
        let flex: FlexGrid = view.viewWithTag(1) as! FlexGrid
        let ss: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height + navigationController!.navigationBar.intrinsicContentSize().height
        flex.frame = CGRectMake(0, ss, view.bounds.size.width, view.bounds.size.height - ss)
        flex.setNeedsDisplay()
    }
}

class DemoCursorCollectionView: XuniCursorCollectionView {

    override init() {
        super.init()
        self.sourceCollection = CustomerData.getCustomerData(100)
    }

    
    override func itemGetter(desiredNumber: NSNumber!) -> NSMutableArray! {
        return CustomerData.getCustomerData(desiredNumber == nil ? 100 : Int(desiredNumber.intValue))
    }

    override func hasMoreItems() -> Bool {
        return sourceCollection.count < 400
    }
}