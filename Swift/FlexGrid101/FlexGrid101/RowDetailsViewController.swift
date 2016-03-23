//
//  RowDetailsViewController.swift
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class RowDetailsViewController: UIViewController {

    @IBOutlet weak var grid: FlexGrid!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.grid.isReadOnly = true
        self.grid.itemsSource = CustomerData.getCustomerData(100)
        let rowHeaderLoadingEventHandler: IXuniEventHandler = {(sender: NSObject!, args: XuniEventArgs!) -> Void in
            let e: FlexGridRowHeaderLoadingEventArgs = (args as! FlexGridRowHeaderLoadingEventArgs)
            let btn: UIButton = UIButton(type: .Custom)
            btn.setImage(UIImage(named: "show"), forState: (.Normal))
            btn.setImage(UIImage(named: "hide"), forState: (.Selected))
            btn.imageView!.contentMode = .ScaleAspectFit
            e.button = btn
        }
        self.grid.detailProvider.gridRowHeaderLoading.addHandler(rowHeaderLoadingEventHandler, forObject: self)
        let detailCellCreatingHandler: IXuniEventHandler = {(sender: NSObject!, args: XuniEventArgs!) -> Void in
            let e: FlexGridDetailCellCreatingEventArgs = (args as! FlexGridDetailCellCreatingEventArgs)
            let flex: FlexGrid = FlexGrid()
            flex.itemsSource = NSMutableArray(array: XuniReflector.getProperties(e.row.dataItem))
            e.view = flex
        }
        self.grid.detailProvider.detailCellCreating.addHandler(detailCellCreatingHandler, forObject: self)
        self.grid.detailProvider.detailVisibilityMode = FlexGridDetailVisibilityMode.ExpandMultiple
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
