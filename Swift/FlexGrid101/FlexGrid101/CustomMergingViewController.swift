//
//  CustomMergingViewController.h
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class CustomMergingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.grid.selectionMode = GridSelectionMode.Cell
        self.grid.isReadOnly = true
        self.grid.columnHeaderFont = UIFont.boldSystemFontOfSize(self.grid.columnHeaderFont.pointSize)
        let weekdays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        for dayName: String in weekdays {
            let c1: GridColumn = GridColumn()
            c1.header = dayName
            c1.widthType = GridColumnWidth.Star
            c1.width = 1
            c1.dataType = XuniDataType.String
            c1.minWidth = 120
            c1.horizontalAlignment = .Center
            c1.headerHorizontalAlignment = .Center
            c1.allowMerging = true
            self.grid.columns.addObject(c1)
        }
        let timespans: [String] = ["12", "13", "14", "15", "16", "17", "18"]
        for timeSpan: String in timespans {
            let r1: GridRow = GridRow()
            self.grid.rows.addObject(r1)
            self.grid.rowHeaders.setCellData("\(timeSpan):00", forRow: Int32(self.grid.rows.indexOfObject(r1)), inColumn: 0)
        }
        
        self.grid.flexGridSelectionChanged.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridCellRangeEventArgs
            
            let r = eventContainerEventArgs.row
            let c = eventContainerEventArgs.col
            
            let thisShow: String = self.grid.getCellDataForRow(r, inColumn: c, formatted: true).description
            self.showTitle.text = thisShow
            var timetable: String = ""
            for cc in 0 ..< 7 {
                let day: String = (self.grid.columns.objectAtIndex(UInt(cc)) as! GridColumn).header
                var spanStart: String? = nil
                var spanEnd: String? = nil
                for cr in 0 ..< 7 {
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
        
        self.grid.columnHeaders.rows.insertObject(GridRow(), atIndex: 0)
        (self.grid.columnHeaders.rows.objectAtIndex(0) as! GridRow).allowMerging = true
        self.grid.columnHeaders[0][0] = "Weekday"
        self.grid.columnHeaders[0][1] = "Weekday"
        self.grid.columnHeaders[0][2] = "Weekday"
        self.grid.columnHeaders[0][3] = "Weekday"
        self.grid.columnHeaders[0][4] = "Weekday"
        self.grid.columnHeaders[0][5] = "Weekend"
        self.grid.columnHeaders[0][6] = "Weekend"
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
        self.grid.setCellData("Wheel of Fortune", forRow: 5, inColumn: 0)
        self.grid.setCellData("Wheel of Fortune", forRow: 5, inColumn: 1)
        self.grid.setCellData("Wheel of Fortune", forRow: 5, inColumn: 2)
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
        self.grid.allowMerging = GridAllowMerging.All
        self.grid.autoSizeColumn(0, header: true)
    }

    @IBOutlet weak var grid: FlexGrid!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showTimetable: UILabel!
}
//
//  CustomMergingViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

class CustomMergingFlexGrid: FlexGrid {

    override func prepareForInterfaceBuilder() {
        self.columnHeaderFont = UIFont.boldSystemFontOfSize(self.columnHeaderFont.pointSize)
        let weekdays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        for dayName: String in weekdays {
            let c1: GridColumn = GridColumn()
            c1.header = dayName
            c1.widthType = GridColumnWidth.Star
            c1.width = 1
            c1.dataType = XuniDataType.String
            c1.minWidth = 120
            c1.horizontalAlignment = .Center
            c1.headerHorizontalAlignment = .Center
            c1.allowMerging = true
            self.columns.addObject(c1)
        }
        let timespans: [String] = ["12", "13", "14", "15", "16", "17", "18"]
        for timeSpan: String in timespans {
            let r1: GridRow = GridRow()
            self.rows.addObject(r1)
            self.rowHeaders.setCellData("\(timeSpan):00", forRow: Int32(self.rows.indexOfObject(r1)), inColumn: 0)
        }
        self.columnHeaders.rows.insertObject(GridRow(), atIndex: 0)
        (self.columnHeaders.rows.objectAtIndex(0) as! GridRow).allowMerging = true
        self.columnHeaders[0][0] = "Weekday"
        self.columnHeaders[0][1] = "Weekday"
        self.columnHeaders[0][2] = "Weekday"
        self.columnHeaders[0][3] = "Weekday"
        self.columnHeaders[0][4] = "Weekday"
        self.columnHeaders[0][5] = "Weekend"
        self.columnHeaders[0][6] = "Weekend"
        self.setCellData("Walker", forRow: 0, inColumn: 0)
        self.setCellData("Morning Show", forRow: 0, inColumn: 1)
        self.setCellData("Morning Show", forRow: 0, inColumn: 2)
        self.setCellData("Sports", forRow: 0, inColumn: 3)
        self.setCellData("Weather", forRow: 0, inColumn: 4)
        self.setCellData("N/A", forRow: 0, inColumn: 5)
        self.setCellData("N/A", forRow: 0, inColumn: 6)
        self.setCellData("N/A", forRow: 1, inColumn: 5)
        self.setCellData("N/A", forRow: 1, inColumn: 6)
        self.setCellData("N/A", forRow: 2, inColumn: 5)
        self.setCellData("N/A", forRow: 2, inColumn: 6)
        self.setCellData("N/A", forRow: 3, inColumn: 5)
        self.setCellData("N/A", forRow: 3, inColumn: 6)
        self.setCellData("N/A", forRow: 4, inColumn: 5)
        self.setCellData("N/A", forRow: 4, inColumn: 6)
        self.setCellData("Today Show", forRow: 1, inColumn: 0)
        self.setCellData("Today Show", forRow: 1, inColumn: 1)
        self.setCellData("Today Show", forRow: 2, inColumn: 0)
        self.setCellData("Today Show", forRow: 2, inColumn: 1)
        self.setCellData("Sesame Street", forRow: 1, inColumn: 2)
        self.setCellData("Football", forRow: 1, inColumn: 3)
        self.setCellData("Football", forRow: 2, inColumn: 3)
        self.setCellData("Market Watch", forRow: 1, inColumn: 4)
        self.setCellData("Kids Zone", forRow: 2, inColumn: 2)
        self.setCellData("Soap Opera", forRow: 2, inColumn: 4)
        self.setCellData("News", forRow: 3, inColumn: 0)
        self.setCellData("News", forRow: 3, inColumn: 1)
        self.setCellData("News", forRow: 3, inColumn: 2)
        self.setCellData("News", forRow: 3, inColumn: 3)
        self.setCellData("News", forRow: 3, inColumn: 4)
        self.setCellData("News", forRow: 4, inColumn: 0)
        self.setCellData("News", forRow: 4, inColumn: 1)
        self.setCellData("News", forRow: 4, inColumn: 2)
        self.setCellData("News", forRow: 4, inColumn: 3)
        self.setCellData("News", forRow: 4, inColumn: 4)
        self.setCellData("Weel of Fortune", forRow: 5, inColumn: 0)
        self.setCellData("Weel of Fortune", forRow: 5, inColumn: 1)
        self.setCellData("Weel of Fortune", forRow: 5, inColumn: 2)
        self.setCellData("Jeopardy", forRow: 5, inColumn: 3)
        self.setCellData("Jeopardy", forRow: 5, inColumn: 4)
        self.setCellData("Movie", forRow: 5, inColumn: 5)
        self.setCellData("Movie", forRow: 6, inColumn: 5)
        self.setCellData("Golf", forRow: 5, inColumn: 6)
        self.setCellData("Golf", forRow: 6, inColumn: 6)
        self.setCellData("Night Show", forRow: 6, inColumn: 0)
        self.setCellData("Night Show", forRow: 6, inColumn: 1)
        self.setCellData("Sports", forRow: 6, inColumn: 2)
        self.setCellData("Big Brother", forRow: 6, inColumn: 3)
        self.setCellData("Big Brother", forRow: 6, inColumn: 4)
        self.allowMerging = GridAllowMerging.All
        self.autoSizeColumn(0, header: true)
    }
}