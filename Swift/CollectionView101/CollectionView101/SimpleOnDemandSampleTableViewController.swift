//
//  SimpleOnDemandSampleTableViewController.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreKit

class SimpleOnDemandSampleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView = SimpleSampleCollectionView()
        self.collectionView.loadMoreItems(nil, completion: {() -> Void in
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.collectionView.itemCount)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("YouTubeEntryCell", forIndexPath: indexPath)
        let thisData: SampleData = (self.collectionView.items[indexPath.row] as! SampleData)
        cell.textLabel!.text = thisData.title
        cell.detailTextLabel!.text = thisData.subtitle
        return cell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastSectionIndex: Int = tableView.numberOfSections - 1
        let lastRowIndex: Int = tableView.numberOfRowsInSection(lastSectionIndex) - 1
        if (indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex) {
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                if self.collectionView.hasMoreItems() {
                    self.collectionView.loadMoreItems(nil, completion: {() -> Void in
                        self.tableView.reloadData()
                    })
                }
            })
        }
    }

    var collectionView: SimpleSampleCollectionView! = nil
    var lastRendered: Int = 0
}


import XuniCoreKit
let LOAD_PAGE_SIZE = 10
class SimpleSampleCollectionView: XuniCursorCollectionView {

    override func hasMoreItems() -> Bool {
        return self.itemCount < 500
    }
    
    override func itemGetter(desiredNumber: NSNumber!) -> NSMutableArray! {
        let dataToAppend = NSMutableArray()
        let exists: Int32 = self.itemCount
        let wanted: Int32 = desiredNumber == nil ? 50 : desiredNumber.intValue
        for var i = exists; i < exists + wanted; i++ {
            dataToAppend.addObject(SampleData(title: "My Data Item \(i + 1)", subtitle: "created at: \(NSDate())"))
        }
        return dataToAppend
    }
}