//
//  GroupingSampleTableViewController.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreKit

class GroupingSampleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView = YouTubeCollectionView(query: "xamarin", orderBy: "relevance")
        collectionView.loadMoreItems(50, completion: {() -> Void in
            let gd: XuniPropertyGroupDescription = XuniPropertyGroupDescription(property: "channelTitle")
            self.collectionView.groupDescriptions.addObject(gd)
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.collectionView.groups.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group: XuniCollectionViewGroup = self.collectionView.groups[section] as! XuniCollectionViewGroup
        return group.items.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        let group: XuniCollectionViewGroup = self.collectionView.groups[section] as! XuniCollectionViewGroup
        let thisData: SampleData = (group.items[0] as! SampleData)
        return thisData.channelTitle
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
        let group: XuniCollectionViewGroup = self.collectionView.groups[indexPath.section] as! XuniCollectionViewGroup
        let thisData: SampleData = (group.items[indexPath.row] as! SampleData)
        UIApplication.sharedApplication().openURL(NSURL(string: thisData.link)!)
    }

    var collectionView: YouTubeCollectionView!
}