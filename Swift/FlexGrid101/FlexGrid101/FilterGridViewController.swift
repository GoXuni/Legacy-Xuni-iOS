//
//  FilterGridViewController.h
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class FilterGridViewController: UIViewController {
    @IBOutlet weak var flex: FlexGrid!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
    }
}
//
//  FilterGridViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//