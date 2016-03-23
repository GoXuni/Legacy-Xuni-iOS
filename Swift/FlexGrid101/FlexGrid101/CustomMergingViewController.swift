//
//  CustomMergingViewController.swift
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class CustomMergingViewController: UIViewController {
    @IBOutlet weak var grid: FlexGrid!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showTimetable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.grid.selectionMode = FlexSelectionMode.Cell
        self.grid.isReadOnly = true
        
        let weekdays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        for dayName: String in weekdays {
            let c1: FlexColumn = FlexColumn()
            c1.header = dayName
            c1.widthType = FlexColumnWidth.Star
            c1.width = 1
            c1.dataType = XuniDataType.String
            c1.minWidth = 120
            c1.allowMerging = true
            self.grid.columns.addObject(c1)
        }
        
        let timespans: [String] = ["12", "13", "14", "15", "16", "17", "18"]
        for timeSpan: String in timespans {
            let r1: FlexRow = FlexRow()
            self.grid.rows.addObject(r1)
            self.grid.rowHeaders.setCellData("\(timeSpan):00", forRow: Int32(self.grid.rows.indexOfObject(r1)), inColumn: 0)
        }
        self.grid.flexGridSelectionChanged.addHandler({(sender: NSObject!, args: XuniEventArgs!) -> Void in
            let e: FlexCellRangeEventArgs = (args as! FlexCellRangeEventArgs)
            let r: Int32 = e.row
            let c: Int32 = e.col
            let thisShow: String = self.grid.getCellDataForRow(r, inColumn: c, formatted: true).description
            self.showTitle.text = thisShow
            var timetable: String = ""
            for var cc = 0; cc < 7; cc++ {
                let day: String = ((self.grid.columns.objectAtIndex(UInt(cc)) as! FlexColumn)).header
                var spanStart: String? = nil
                var spanEnd: String? = nil
                for var cr = 0; cr < 7; cr++ {
                    let candidate: String = self.grid.getCellDataForRow(Int32(cr), inColumn: Int32(cc), formatted: true).description
                    if (candidate == thisShow) {
                        if spanStart == nil {
                            spanStart = self.grid.rowHeaders.getCellDataForRow(Int32(cr), inColumn: 0, formatted: true).description
                        }
                    }
                    else {
                        if spanStart != nil {
                            spanEnd = self.grid.rowHeaders.getCellDataForRow(Int32(cr), inColumn: 0, formatted: true).description
                        }
                    }
                }
                if spanStart != nil && spanEnd == nil {
                    spanEnd = "19:00"
                }
                if spanStart != nil && spanEnd != nil {
                    timetable = "\(timetable)\(day): \(spanStart!)-\(spanEnd!)\r"
                }
            }
            self.showTimetable.text = timetable
            }, forObject: self)
        
        self.grid.setCellData("Walker", forRow: 0, inColumn: 0)
        self.grid.setCellData("Morning Show", forRow: 0, inColumn: 1)
        self.grid.setCellData("Morning Show", forRow: 0, inColumn: 2)
        self.grid.setCellData("Sports", forRow: 0, inColumn: 3)
        self.grid.setCellData("Weather", forRow: 0, inColumn: 4)
        self.grid.setCellData("N/A", forRow: 0, inColumn: 5)
        self.grid.setCellData("N/A", forRow: 0, inColumn: 6)
        self.grid.setCellData("N/A", forRow: 1, inColumn: 5)
        self.grid.setCellData("N/A", forRow: 1, inColumn: 6)
        self.grid.setCellData("N/A", forRow: 2, inColumn: 5)
        self.grid.setCellData("N/A", forRow: 2, inColumn: 6)
        self.grid.setCellData("N/A", forRow: 3, inColumn: 5)
        self.grid.setCellData("N/A", forRow: 3, inColumn: 6)
        self.grid.setCellData("N/A", forRow: 4, inColumn: 5)
        self.grid.setCellData("N/A", forRow: 4, inColumn: 6)
        self.grid.setCellData("Today Show", forRow: 1, inColumn: 0)
        self.grid.setCellData("Today Show", forRow: 1, inColumn: 1)
        self.grid.setCellData("Today Show", forRow: 2, inColumn: 0)
        self.grid.setCellData("Today Show", forRow: 2, inColumn: 1)
        self.grid.setCellData("Sesame Street", forRow: 1, inColumn: 2)
        self.grid.setCellData("Football", forRow: 1, inColumn: 3)
        self.grid.setCellData("Football", forRow: 2, inColumn: 3)
        self.grid.setCellData("Market Watch", forRow: 1, inColumn: 4)
        self.grid.setCellData("Kids Zone", forRow: 2, inColumn: 2)
        self.grid.setCellData("Soap Opera", forRow: 2, inColumn: 4)
        self.grid.setCellData("News", forRow: 3, inColumn: 0)
        self.grid.setCellData("News", forRow: 3, inColumn: 1)
        self.grid.setCellData("News", forRow: 3, inColumn: 2)
        self.grid.setCellData("News", forRow: 3, inColumn: 3)
        self.grid.setCellData("News", forRow: 3, inColumn: 4)
        self.grid.setCellData("News", forRow: 4, inColumn: 0)
        self.grid.setCellData("News", forRow: 4, inColumn: 1)
        self.grid.setCellData("News", forRow: 4, inColumn: 2)
        self.grid.setCellData("News", forRow: 4, inColumn: 3)
        self.grid.setCellData("News", forRow: 4, inColumn: 4)
        self.grid.setCellData("Weel of Fortune", forRow: 5, inColumn: 0)
        self.grid.setCellData("Weel of Fortune", forRow: 5, inColumn: 1)
        self.grid.setCellData("Weel of Fortune", forRow: 5, inColumn: 2)
        self.grid.setCellData("Jeopardy", forRow: 5, inColumn: 3)
        self.grid.setCellData("Jeopardy", forRow: 5, inColumn: 4)
        self.grid.setCellData("Movie", forRow: 5, inColumn: 5)
        self.grid.setCellData("Movie", forRow: 6, inColumn: 5)
        self.grid.setCellData("Golf", forRow: 5, inColumn: 6)
        self.grid.setCellData("Golf", forRow: 6, inColumn: 6)
        self.grid.setCellData("Night Show", forRow: 6, inColumn: 0)
        self.grid.setCellData("Night Show", forRow: 6, inColumn: 1)
        self.grid.setCellData("Sports", forRow: 6, inColumn: 2)
        self.grid.setCellData("Big Brother", forRow: 6, inColumn: 3)
        self.grid.setCellData("Big Brother", forRow: 6, inColumn: 4)
        
        self.grid.allowMerging = FlexGridAllowMerging.Cells
        self.grid.autoSizeColumn(0, header: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
