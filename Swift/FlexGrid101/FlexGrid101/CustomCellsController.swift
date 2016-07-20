//
//  CustomCellsController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreDynamicKit
import XuniFlexGridDynamicKit
import XuniGaugeDynamicKit

class CustomCellsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.autoGenerateColumns = false
        self.flex.isReadOnly = true
        self.flex.selectionMode = GridSelectionMode.Row
        let c1: GridColumn = GridColumn()
        c1.header = NSLocalizedString("First Name", comment: "")
        c1.binding = "firstName"
        let c2: GridColumn = GridColumn()
        c2.header = NSLocalizedString("Last Name", comment: "")
        c2.binding = "lastName"
        let c3: GridColumn = GridColumn()
        c3.header = NSLocalizedString("Total Orders", comment: "")
        c3.binding = "orderTotal"
        self.flex.columns.addObject(c1)
        self.flex.columns.addObject(c2)
        self.flex.columns.addObject(c3)
        self.flex.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
        self.starSizing(self.flex)
        self.flex.flexGridFormatItem.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridFormatItemEventArgs
            eventContainerEventArgs.cancel = false
            let g: FlexGrid = self.flex
            let col: GridColumn = g.columns![eventContainerEventArgs.col] as! GridColumn
            if (col.binding == "orderTotal") {
                let v: NSObject! = eventContainerEventArgs.panel.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: false)
                if v != nil {
                    if !v.description.isEqual(NSLocalizedString("Total Orders", comment:"")) {
                        let radialGauge: XuniRadialGauge = XuniRadialGauge()
                        let lower: XuniGaugeRange = XuniGaugeRange(gauge: radialGauge)
                        lower.min = 0
                        lower.max = 40
                        lower.color = UIColor(red: 0.133, green: 0.694, blue: 0.298, alpha: 1)
                        let middle: XuniGaugeRange = XuniGaugeRange(gauge: radialGauge)
                        middle.min = 40
                        middle.max = 80
                        middle.color = UIColor(red: 1, green: 0.502, blue: 0.502, alpha: 1)
                        let upper: XuniGaugeRange = XuniGaugeRange(gauge: radialGauge)
                        upper.min = 80
                        upper.max = 100
                        upper.color = UIColor(red: 0, green: 0.635, blue: 0.91, alpha: 1)
                        radialGauge.ranges.addObject(lower)
                        radialGauge.ranges.addObject(middle)
                        radialGauge.ranges.addObject(upper)
                        radialGauge.backgroundColor = UIColor.clearColor()
                        radialGauge.showText = XuniShowText.None
                        radialGauge.thickness = 0.6
                        radialGauge.min = 0
                        radialGauge.max = 100
                        radialGauge.loadAnimation = nil
                        radialGauge.value = CDouble(v.description)! * (100.0 / 90000.0)
                        radialGauge.showRanges = false
                        let r: CGRect = eventContainerEventArgs.panel.getCellRectForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col)
                        let t: XuniRect = XuniRect(left: 0, top: 0, width: Double(r.size.width), height: Double(r.size.height))
                        radialGauge.rectGauge = t
                        radialGauge.frame = CGRectMake(0, 0, r.size.width, r.size.height)
                        var image: UIImage = UIImage()
                        image = UIImage(data: radialGauge.getImage())!
                        image.drawInRect(r)
                        eventContainerEventArgs.cancel = true
                    }
                }
            }
        }, forObject: self)
    }

    func starSizing(g: FlexGrid) {
        for i:UInt in 0 ..< g.columns.count {
            let c: GridColumn = g.columns![Int32(i)] as! GridColumn
            c.widthType = GridColumnWidth.Star
            c.width = (i == 0) ? 5 : (i == 3) ? 3 : 4
        }
    }

    @IBOutlet weak var flex: FlexGrid!
}
//
//  CustomCellsController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//