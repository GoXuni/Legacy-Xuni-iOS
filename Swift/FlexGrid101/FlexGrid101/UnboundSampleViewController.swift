//
//  UnboundSampleViewController.h
//  FlexGrid101
//
//  Created by Mykola Kotyuck on 16.06.16.
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class UnboundSampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // allow merging
        self.grid.allowMerging = GridAllowMerging.All
        // add rows/columns to the unbound grid
        for _ in 0 ..< 12 {
            grid.columns.addObject(GridColumn())
        }
        for _ in 0 ..< 500 {
            grid.rows.addObject(GridRow())
        }
        // populate the unbound grid with some stuff
        for r:UInt in 0 ..< grid.rows.count {
            for c:UInt in 0 ..< grid.columns.count {
                self.grid.setCellData("cell [\(r), \(c)]", forRow: Int32(r), inColumn: Int32(c))
            }
        }
            // set unbound column headers
        let ch: GridPanel = grid.columnHeaders
        ch.rows.addObject(GridRow())
        // one header row for years, one for quarters
        for c:UInt in 0 ..< ch.columns.count {
            ch[0][Int32(c)] = 2016 + c / 4
            // year
            ch[1][Int32(c)] = "Q \(c % 4 + 1)"
            // quarter
        }
        // allow merging the first fixed row
        (ch.rows[Int32(0)] as! GridRow).allowMerging = true
            // set unbound row headers
        let rh: GridPanel = grid.rowHeaders
        rh.columns.addObject(GridColumn())
        for c:UInt in 0 ..< rh.columns.count {
            (rh.columns[Int32(c)] as! GridColumn).width = 60
            for r:UInt in 0 ..< rh.rows.count {
                rh[Int32(r)][Int32(c)] = "hdr \(c == 0 ? r / 2 : r), \(c)"
            }
        }
        // allow merging the first fixed column
        (rh.columns[Int32(0)] as! GridColumn).allowMerging = true
        grid.autoSizeColumns(0, to: 1, header: true)
        grid.autoSizeColumns()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var grid: FlexGrid!
}
//
//  UnboundSampleViewController.m
//  FlexGrid101
//
//  Created by Mykola Kotyuck on 16.06.16.
//  Copyright © 2016 GrapeCity. All rights reserved.
//