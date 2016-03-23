//
//  ViewController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let samples = [NSLocalizedString("Getting Started", comment: ""), NSLocalizedString("Column Definitions", comment: ""), NSLocalizedString("Selection Modes", comment: ""), NSLocalizedString("Editing", comment: ""), NSLocalizedString("Custom Cells", comment: ""), NSLocalizedString("Grouping", comment: ""), NSLocalizedString("Filter", comment: ""), NSLocalizedString("Full Text Filter", comment: ""), NSLocalizedString("Edit Confirmation", comment: ""), NSLocalizedString("Star Sizing", comment: ""), NSLocalizedString("Cell Freezing & Merging", comment: ""), NSLocalizedString("Conditional Formatting", comment: ""), NSLocalizedString("Editing form", comment: ""), NSLocalizedString("Column Layout", comment: ""), NSLocalizedString("On Demand Loading", comment: "")]
    let SimpleIdentifier = "SimpleIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: SimpleIdentifier)
        }
        
        let row = indexPath.row
        cell!.textLabel?.text = samples[row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row){
        case 0:
            self.performSegueWithIdentifier("GettingStartedSegue", sender: tableView)
        case 1:
            self.performSegueWithIdentifier("ColumnDefinitionsSegue", sender: tableView)
        case 2:
            self.performSegueWithIdentifier("SelectionModesSegue", sender: tableView)
        case 3:
            self.performSegueWithIdentifier("EditingSegue", sender: tableView)
        case 4:
            self.performSegueWithIdentifier("CustomCellsSegue", sender: tableView)
        case 5:
            self.performSegueWithIdentifier("GroupingSegue", sender: tableView)
        case 6:
            self.performSegueWithIdentifier("FilterSegue", sender:tableView)
        case 7:
            self.performSegueWithIdentifier("FullTextFilterSegue", sender:tableView)
        case 8:
            self.performSegueWithIdentifier("EditConfirmationSegue", sender:tableView)
        case 9:
            self.performSegueWithIdentifier("StarSizingSegue", sender:tableView)
        case 10:
            self.performSegueWithIdentifier("FrozenCellsSegue", sender:tableView)
        case 11:
            self.performSegueWithIdentifier("ConditionalFormattingSegue", sender:tableView)
        case 12:
            self.performSegueWithIdentifier("EditingFormSegue", sender:tableView)
        case 13:
            self.performSegueWithIdentifier("ColumnLayoutSegue", sender:tableView)
        case 14:
            self.performSegueWithIdentifier("OnDemandLoadingSegue", sender:tableView)
        default:
            break
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var table = self.view.viewWithTag(1) as! UITableView
        table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
    }
}

