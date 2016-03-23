//
//  ViewController.swift
//  Calendar101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let samplesTitle = [
        "Getting Started",
        "Vertical Orientation",
        "Custom Day Content",
        "Custom Header",
        "Custom Appearance",
        "Popup Editor",
        "Custom Selection"]
    
    let samplesDescription = [
        "Shows a basic calendar with selection and interaction.",
        "Shows a calendar with vertical navigation/scrolling.",
        "Shows how to customize a day slot to show custom content.",
        "Shows a custom header inspired by a popular Android or iOS calendar app.",
        "Shows a calendar with a custom style.",
        "Shows how to use the control as a pop-up date selector.",
        "Shows custom selection scenarios."]
    
    let SimpleIdentifier = "SimpleIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let table = self.view.viewWithTag(1) as! UITableView
        table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samplesTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell : UITableViewCell?
        var imageName : String
        
        imageName = samplesTitle[row].stringByReplacingOccurrencesOfString(" ", withString: "")
        imageName = imageName.lowercaseString + ".png"
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: SimpleIdentifier)
        }
        
        cell!.textLabel?.text = samplesTitle[row]
        cell!.textLabel?.textColor = UIColor(red: 176.0 / 255, green: 15.0 / 255, blue: 80.0 / 255, alpha: 1)
        cell!.detailTextLabel?.text = samplesDescription[row]
        cell!.detailTextLabel?.textColor = UIColor.grayColor()
        cell!.imageView?.image = UIImage(named: imageName)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row) {
        case 0:
            self.performSegueWithIdentifier("GettingStartedSegue", sender:tableView)
            break;
        case 1:
            self.performSegueWithIdentifier("VerticalOrientationSegue", sender:tableView)
            break;
        case 2:
            self.performSegueWithIdentifier("CustomDayContentSegue", sender:tableView)
            break;
        case 3:
            self.performSegueWithIdentifier("CustomHeaderSegue", sender:tableView)
            break;
        case 4:
            self.performSegueWithIdentifier("CustomAppearanceSegue", sender:tableView)
            break;
        case 5:
            self.performSegueWithIdentifier("PopupEditorSegue", sender:tableView)
            break;
        case 6:
            self.performSegueWithIdentifier("CustomSelectionSegue", sender:tableView)
            break;
        default:
            break;
        }
    }
}

