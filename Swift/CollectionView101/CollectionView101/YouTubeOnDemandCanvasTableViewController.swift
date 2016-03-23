//
//  YouTubeOnDemandCanvasTableViewController.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreKit

class YouTubeOnDemandCanvasTableViewController: UITableViewController {
    var collectionView: YouTubeCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView = YouTubeCollectionView(query: "", orderBy: "relevance")
        collectionView.loadMoreItems(50, completion: {() -> Void in
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
        return Int(self.collectionView!.itemCount)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("YouTubeEntryCell", forIndexPath: indexPath)
        let thisData: SampleData = (self.collectionView.items[indexPath.row] as! SampleData)
        cell.textLabel!.text = thisData.title
        cell.detailTextLabel!.text = thisData.subtitle
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {() -> Void in
            if let data = NSData(contentsOfURL:NSURL(string: thisData.thumbnail)!) {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    cell.imageView?.image = UIImage(data: data)
                    cell.layoutSubviews()
                })
            }
        })
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let thisData: SampleData = (self.collectionView.items[indexPath.row] as! SampleData)
        UIApplication.sharedApplication().openURL(NSURL(string: thisData.link)!)
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastSectionIndex: Int = tableView.numberOfSections - 1
        let lastRowIndex: Int = tableView.numberOfRowsInSection(lastSectionIndex) - 1
        if (indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex) {
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                self.collectionView.loadMoreItems(50, completion: {() -> Void in
                    self.tableView.reloadData()
                })
            })
        }
    }
}