//
//  ViewController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let samples = ["Getting Started", "Basic Chart Types", "Mixed Chart Types", "Financial Chart", "Bubble Chart", "Custom Tooltips", "Theming", "Styling Series", "Customizing Axes", "Legends and Titles", "Selection Modes", "Toggle Series", "Animation Options", "Dynamic Charts", "Zooming and Scrolling", "Hit Test", "Snapshot", "Multiple Axes", "Data Label"]
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
            self.performSegueWithIdentifier("GettingStartedSegue", sender:tableView)
        case 1:
            self.performSegueWithIdentifier("BasicChartTypesSegue", sender:tableView)
        case 2:
            self.performSegueWithIdentifier("MixedChartTypesSegue", sender:tableView)
        case 3:
            self.performSegueWithIdentifier("FinancialChartSegue", sender:tableView)
        case 4:
            self.performSegueWithIdentifier("BubbleChartSegue", sender:tableView)
        case 5:
            self.performSegueWithIdentifier("CustomTooltipsSegue", sender:tableView)
        case 6:
            self.performSegueWithIdentifier("ThemingSegue", sender:tableView)
        case 7:
            self.performSegueWithIdentifier("StylingSeriesSegue", sender:tableView)
        case 8:
            self.performSegueWithIdentifier("CustomizingAxesSegue", sender:tableView)
        case 9:
            self.performSegueWithIdentifier("LegendAndTitlesSegue", sender:tableView)
        case 10:
            self.performSegueWithIdentifier("SelectionModesSegue", sender:tableView)
        case 11:
            self.performSegueWithIdentifier("ToggleSeriesSegue", sender:tableView)
        case 12:
            self.performSegueWithIdentifier("AnimationOptionsSegue", sender:tableView)
        case 13:
            self.performSegueWithIdentifier("DynamicChartsSegue", sender:tableView)
        case 14:
            self.performSegueWithIdentifier("ZoomingAndScrollingSegue", sender:tableView)
        case 15:
            self.performSegueWithIdentifier("HitTestSegue", sender:tableView)
        case 16:
            self.performSegueWithIdentifier("SnapshotSegue", sender:tableView)
        case 17:
            self.performSegueWithIdentifier("MultipleAxesSegue", sender:tableView)
        case 18:
            self.performSegueWithIdentifier("DataLabelSegue", sender:tableView)
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

