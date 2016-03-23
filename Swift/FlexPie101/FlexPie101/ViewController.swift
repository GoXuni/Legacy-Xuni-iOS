//
//  ViewController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let samples = [NSLocalizedString("Getting Started", comment: "Getting Started"), NSLocalizedString("Basic Features", comment: "Basic Features"), NSLocalizedString("Legend Sample", comment: "Legend and Titles"), NSLocalizedString("Selection", comment: "Selection Sample"), NSLocalizedString("Theming", comment: "Theming"),
        NSLocalizedString("Export Image", comment: "Snapshot") ]
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
            break
        case 1:
            self.performSegueWithIdentifier("BasicFeaturesSegue", sender: tableView)
            break
        case 2:
            self.performSegueWithIdentifier("LegendAndTitlesSegue", sender: tableView)
            break
        case 3:
            self.performSegueWithIdentifier("SelectionSampleSegue", sender: tableView)
            break
        case 4:
            self.performSegueWithIdentifier("ThemingSegue", sender: tableView)
            break
        case 5:
            self.performSegueWithIdentifier("SnapshotSegue", sender: tableView)
            break
        default:
            break
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let table = self.view.viewWithTag(1) as! UITableView
        table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
    }
}



