//
//  YouTubeOnDemandSampleViewController.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreKit

class YouTubeOnDemandSampleViewController: UIViewController {

    @IBAction func searchModeChanged(sender: AnyObject) {
        self.updateSearch()
    }

    @IBAction func startSearch(sender: AnyObject) {
        self.textInput.resignFirstResponder()
        self.updateSearch()
    }

    func updateSearch() {
        let canvas: YouTubeOnDemandCanvasTableViewController = self.childViewControllers[0] as! YouTubeOnDemandCanvasTableViewController
        var selArray: [String] = ["relevance", "date", "viewCount", "rating", "title"]
        canvas.collectionView = YouTubeCollectionView(query: self.textInput.text!, orderBy: selArray[self.sortSelect.selectedSegmentIndex])
        canvas.collectionView.loadMoreItems(50, completion: {() -> Void in
            canvas.tableView.reloadData()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortSelect.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var sortSelect: UISegmentedControl!
    @IBOutlet weak var textInput: UITextField!
}