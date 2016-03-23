//
//  ViewController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let samplesTitle = [
        NSLocalizedString("Getting Started", comment: ""),
        NSLocalizedString("Basic Chart Types", comment: ""),
        NSLocalizedString("Mixed Chart Types", comment: ""),
        NSLocalizedString("Financial Chart", comment: ""),
        NSLocalizedString("Bubble Chart", comment: ""),
        NSLocalizedString("Custom Tooltips", comment: ""),
        NSLocalizedString("Data Labels", comment: ""),
        NSLocalizedString("Annotations", comment: ""),
        NSLocalizedString("Line Marker", comment: ""),
        NSLocalizedString("Customizing Axes", comment: ""),
        NSLocalizedString("Multiple Axes", comment: ""),
        NSLocalizedString("Legend and Titles", comment: ""),
        NSLocalizedString("Conditional Formatting", comment: ""),
        NSLocalizedString("Custom Plot Elements", comment: ""),
        NSLocalizedString("Selection Modes", comment: ""),
        NSLocalizedString("Toggle Series", comment: ""),
        NSLocalizedString("Load Animation Mode", comment: ""),
        NSLocalizedString("Update Animation", comment: ""),
        NSLocalizedString("Dynamic Charts", comment: ""),
        NSLocalizedString("Hit Test", comment: ""),
        NSLocalizedString("Scrolling", comment: ""),
        NSLocalizedString("Zooming and Scrolling", comment: ""),
        NSLocalizedString("Theming", comment: ""),
        NSLocalizedString("Styling Series", comment: ""),
        NSLocalizedString("Export Image", comment: "")]
    
    let samplesDescription = [
        NSLocalizedString("Shows a simple chart with tooltips.", comment: ""),
        NSLocalizedString("Shows the basic chart types and stacking options.", comment: ""),
        NSLocalizedString("Shows a composite chart.", comment: ""),
        NSLocalizedString("Shows stock data in a candle chart.", comment: ""),
        NSLocalizedString("Shows a bubble chart.", comment: ""),
        NSLocalizedString("Shows a customized tooltip.", comment: ""),
        NSLocalizedString("Shows a simple chart with static data labels.", comment: ""),
        NSLocalizedString("Shows how to display annotations on FlexChart.", comment: ""),
        NSLocalizedString("Shows a moveable marker on top of the chart.", comment: ""),
        NSLocalizedString("Shows customized axis style and label format.", comment: ""),
        NSLocalizedString("Shows a chart with mutiple Y axes.", comment: ""),
        NSLocalizedString("Shows basic chart headers and axis titles.", comment: ""),
        NSLocalizedString("Shows conditional formatting by customizing plot elements.", comment: ""),
        NSLocalizedString("Shows how to fully customize plot elements.", comment: ""),
        NSLocalizedString("Shows the different selection modes.", comment: ""),
        NSLocalizedString("Shows the ability to toggle a series visibility.", comment: ""),
        NSLocalizedString("Shows animation modes when data is loaded.", comment: ""),
        NSLocalizedString("Shows animation when data is updated.", comment: ""),
        NSLocalizedString("Shows a dynamic, “live” chart.", comment: ""),
        NSLocalizedString("Demonstrates use of the FlexChart's hitTest method.", comment: ""),
        NSLocalizedString("Shows a chart with panning (or scrolling) along the axes.", comment: ""),
        NSLocalizedString("Shows stretch zoom-out and pinch zoom-in gestures.", comment: ""),
        NSLocalizedString("Shows the built-in palettes.", comment: ""),
        NSLocalizedString("Shows custom series styling.", comment: ""),
        NSLocalizedString("Shows how to export an image of FlexChart.", comment: "")]
    
    let samplesImage = [
        "Getting Started",
        "Basic Chart Types",
        "Mixed Chart Types",
        "Financial Chart",
        "Bubble Chart",
        "Custom Tooltips",
        "Data Labels",
        "Annotations",
        "Line Marker",
        "Customizing Axes",
        "Multiple Axes",
        "Legend and Titles",
        "Conditional Formatting",
        "Custom Plot Elements",
        "Selection Modes",
        "Toggle Series",
        "Load Animation Mode",
        "Update Animation",
        "Dynamic Charts",
        "Hit Test",
        "Scrolling",
        "Zooming and Scrolling",
        "Theming",
        "Styling Series",
        "Export Image"]
    
    let SimpleIdentifier = "SimpleIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var table = self.view.viewWithTag(1) as! UITableView
        table.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        imageName = samplesImage[row].stringByReplacingOccurrencesOfString(" ", withString: "")
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
            self.performSegueWithIdentifier("BasicChartTypesSegue", sender:tableView)
            break;
        case 2:
            self.performSegueWithIdentifier("MixedChartTypesSegue", sender:tableView)
            break;
        case 3:
            self.performSegueWithIdentifier("FinancialChartSegue", sender:tableView)
            break;
        case 4:
            self.performSegueWithIdentifier("BubbleChartSegue", sender:tableView)
            break;
        case 5:
            self.performSegueWithIdentifier("CustomTooltipsSegue", sender:tableView)
            break;
        case 6:
            self.performSegueWithIdentifier("DataLabelSegue", sender:tableView)
            break;
        case 7:
            self.performSegueWithIdentifier("AnnotationSegue", sender:tableView)
            break;
        case 8:
            self.performSegueWithIdentifier("CustomLineMarkerSegue", sender:tableView)
            break;
        case 9:
            self.performSegueWithIdentifier("CustomizingAxesSegue", sender:tableView)
            break;
        case 10:
            self.performSegueWithIdentifier("MultipleAxesSegue", sender:tableView)
            break;
        case 11:
            self.performSegueWithIdentifier("LegendsAndTitlesSegue", sender:tableView)
            break;
        case 12:
            self.performSegueWithIdentifier("ConditionalFormattingSegue", sender:tableView)
            break;
        case 13:
            self.performSegueWithIdentifier("CustomPlotElementsSegue", sender:tableView)
            break;
        case 14:
            self.performSegueWithIdentifier("SelectionModesSegue", sender:tableView)
            break;
        case 15:
            self.performSegueWithIdentifier("ToggleSeriesSegue", sender:tableView)
            break;
        case 16:
            self.performSegueWithIdentifier("LoadAnimationSegue", sender:tableView)
            break;
        case 17:
            self.performSegueWithIdentifier("UpdateAnimationSegue", sender:tableView)
            break;
        case 18:
            self.performSegueWithIdentifier("DynamicChartsSegue", sender:tableView)
            break;
        case 19:
            self.performSegueWithIdentifier("HitTestSegue", sender:tableView)
            break;
        case 20:
            self.performSegueWithIdentifier("ScrollingSegue", sender:tableView)
            break;
        case 21:
            self.performSegueWithIdentifier("ZoomingAndScrollingSegue", sender:tableView)
            break;
        case 22:
            self.performSegueWithIdentifier("ThemingSegue", sender:tableView)
            break;
        case 23:
            self.performSegueWithIdentifier("StylingSeriesSegue", sender:tableView)
            break;
        case 24:
            self.performSegueWithIdentifier("SnapshotSegue", sender:tableView)
            break;
        default:
            break;
        }
    }
}

