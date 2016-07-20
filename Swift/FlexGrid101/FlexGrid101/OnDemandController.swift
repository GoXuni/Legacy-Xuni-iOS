//
//  OnDemandController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class OnDemandController: UIViewController {

    @IBAction func startSearching(sender: AnyObject) {
        self.textInput.resignFirstResponder()
        self.updateSearch()
    }

    @IBAction func searchModeChanged(sender: AnyObject) {
        self.updateSearch()
    }

    func updateSearch() {
        var selArray: [String] = ["relevance", "date", "viewCount", "rating", "title"]
        let cv: YouTubeCollectionView = YouTubeCollectionView(query: self.textInput.text!, orderBy: selArray[self.sortSelect.selectedSegmentIndex])
        self.flex.collectionView = cv
        cv.loadMoreItems(50, completion: {() -> Void in
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var dic: [NSObject : AnyObject] = [NSObject : AnyObject]()
        self.flex.columnHeaderFont = UIFont.boldSystemFontOfSize(self.flex.columnHeaderFont.pointSize)
        self.flex.isReadOnly = true
        self.flex.autoGenerateColumns = false
        let thumbnail: GridColumn = GridColumn()
        thumbnail.binding = "thumbnail"
        thumbnail.width = 150
        self.flex.columns.addObject(thumbnail)
        let title: GridColumn = GridColumn()
        title.binding = "title"
        title.wordWrap = true
        self.flex.columns.addObject(title)
        let channel: GridColumn = GridColumn()
        channel.binding = "channelTitle"
        channel.wordWrap = true
        self.flex.columns.addObject(channel)
        
        
        self.flex.flexGridLoadedRows.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            for i:UInt in 0 ..< self.flex.rows.count {
                let row: GridRow = self.flex.rows.objectAtIndex(i) as! GridRow
                row.height = 75
            }
        }, forObject: self)
        self.flex.flexGridFormatItem.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridFormatItemEventArgs
            let col: GridColumn = self.flex.columns.objectAtIndex(UInt(eventContainerEventArgs.col)) as! GridColumn
            if (col.binding == "thumbnail") && eventContainerEventArgs.panel == self.flex.cells {
                let url: String = String(self.flex.getCellDataForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col, formatted: false))
                let imgdata: NSData! = (dic[url] as! NSData!)
                if imgdata == nil {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), {() -> Void in
                        let imgdata: NSData = NSData(contentsOfURL: NSURL(string: url)!)!
                        dispatch_async(dispatch_get_main_queue(), {() -> Void in
                            dic[url] = imgdata
                            self.flex.invalidate()
                        })
                    })
                    eventContainerEventArgs.cancel = true
                    return
                }
                let image: UIImage = UIImage(data:imgdata!)!
                let r: CGRect = eventContainerEventArgs.panel.getCellRectForRow(eventContainerEventArgs.row, inColumn: eventContainerEventArgs.col)
                let imageSize: CGSize = image.size
                let viewSize: CGSize = r.size
                let hfactor: Float = Float(imageSize.width) / Float(viewSize.width)
                let vfactor: Float = Float(imageSize.height) / Float(viewSize.height)
                let factor: Float = fmax(hfactor, vfactor)
                let newWidth: Float = Float(imageSize.width) / factor
                let newHeight: Float = Float(imageSize.height) / factor
                let newRect: CGRect = CGRectMake(r.origin.x + (r.size.width - CGFloat(newWidth)) / 2, r.origin.y + (r.size.height - CGFloat(newHeight)) / 2, CGFloat(newWidth), CGFloat(newHeight))
                image.drawInRect(newRect)
                eventContainerEventArgs.cancel = true
            }
        }, forObject: self)
        self.updateSearch()
    }

    @IBOutlet weak var flex: FlexGrid!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var sortSelect: UISegmentedControl!
}
//
//  OnDemandController.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

import XuniCoreDynamicKit