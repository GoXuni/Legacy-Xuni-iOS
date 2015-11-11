//
//  ViewController.swift
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let samples = ["Getting Started", "Displaying Values", "Using Ranges", "Automatic Scaling", "Direction", "Bullet Graph", "Animation", "Snapshot"]
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
            self.performSegueWithIdentifier("DisplayingValuesSegue", sender: tableView)
            break
        case 2:
            self.performSegueWithIdentifier("UsingRangesSegue", sender: tableView)
            break
        case 3:
            self.performSegueWithIdentifier("AutomaticScalingSegue", sender: tableView)
            break
        case 4:
            self.performSegueWithIdentifier("DirectionSegue", sender: tableView)
            break
        case 5:
            self.performSegueWithIdentifier("BulletGraphSegue", sender: tableView)
            break
        case 6:
            self.performSegueWithIdentifier("CustomAnimationSegue", sender: tableView)
            break
        case 7:
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

