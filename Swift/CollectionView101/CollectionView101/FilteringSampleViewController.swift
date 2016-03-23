//
//  FilteringSampleViewController.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniCoreKit

class FilteringSampleViewController: UIViewController {

    func searchBody() {
        let canvas: FilteringDemoCanvasTableViewController! = self.childViewControllers[0] as! FilteringDemoCanvasTableViewController
        
        canvas.collectionView.filter = {(item: NSObject!) -> Bool in
            if NSString(string: self.searchRequest.text!).length == 0 {
                return Bool(true)
            }
            let sd: SampleData = (item as! SampleData)
            return Bool(sd.title.uppercaseString.containsString(self.searchRequest.text!.uppercaseString) || sd.description.uppercaseString.containsString(self.searchRequest.text!.uppercaseString))
        }
        canvas.tableView.reloadData()
    }

    @IBAction func doSearch(sender: AnyObject) {
        self.searchBody()
        self.searchRequest.resignFirstResponder()
    }

    @IBAction func textChanged(sender: AnyObject) {
        self.searchBody()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var searchRequest: UITextField!
}