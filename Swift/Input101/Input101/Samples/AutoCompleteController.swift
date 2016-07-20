//
//  AutoCompleteController.swift
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

import UIKit
import Foundation
import XuniInputKit

class AutoCompleteController: UIViewController, XuniDropDownDelegate, XuniAutoCompleteDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var highlightDropdown: XuniAutoComplete!
    @IBOutlet weak var delayDropdown: XuniAutoComplete!
    @IBOutlet weak var customDropdown: XuniAutoComplete!
    @IBOutlet weak var filterDropdown: XuniAutoComplete!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
         //Do any additional setup after loading the view.
        highlightDropdown.dropDownHeight = 200;
        highlightDropdown.displayMemberPath = "name"
        highlightDropdown.isAnimated = true
        highlightDropdown.itemsSource = AutoCompleteData.demoData()
		highlightDropdown.showButton = false
        
        delayDropdown.dropDownHeight = 200;
        delayDropdown.displayMemberPath = "name";
        delayDropdown.isAnimated = true
        delayDropdown.itemsSource = AutoCompleteData.demoData()
        delayDropdown.delay = 1000;
        delayDropdown.showButton = false

        customDropdown.tableView.delegate = self;
        customDropdown.tableView.dataSource = self;
        customDropdown.dropDownHeight = 200;
        customDropdown.displayMemberPath = "name";
        customDropdown.isAnimated = true
        customDropdown.highlightedColor = UIColor.redColor()
        customDropdown.itemsSource = AutoCompleteData.demoData()
        
        filterDropdown.dropDownHeight = 200
        filterDropdown.displayMemberPath = "name"
        filterDropdown.isAnimated = true
        filterDropdown.delegate = self
        filterDropdown.itemsSource = AutoCompleteData.demoData()
        filterDropdown.filteringArgs.cancel = true
    }
    
    func filtering(sender: XuniAutoComplete!, eventArgs: XuniAutoCompleteFilteringEventArgs!) {
        sender.collectionView.filter = {(item : NSObject?) -> Bool in
            let data = item as! AutoCompleteData
            let string = data.name as NSString;
            if (string.substringToIndex(1).lowercaseString == "b") {
                return true;
            }
            return false;
        } as IXuniPredicate
        sender.itemsSource =  NSMutableArray(array: sender.collectionView.items)
//        sender.filteringArgs.cancel = false
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customDropdown.temporaryItemSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("simpleIdentifier")
        
        if (cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "simpleIdentifier")
        }
        
        let selectedBackgroundView = UIView.init()
        selectedBackgroundView.backgroundColor = UIColor.init(colorLiteralRed: 0 / 255.0, green: 122 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        cell!.selectedBackgroundView = selectedBackgroundView
        
        let array = ((cell?.contentView.subviews)! as NSArray)
        for view in array
        {
            let v = view as! UIView
            v.removeFromSuperview()
        }
        
        let rect = cell!.contentView.frame;
        let tempArray = customDropdown.temporaryItemSource as NSArray
        let data = tempArray.objectAtIndex(indexPath.row) as! AutoCompleteData
        
        let image = UIImageView.init(image: UIImage.init(named: data.imageString))
        image.frame = CGRect(x: 8, y: 0, width: 48, height: 48)
        cell?.contentView.addSubview(image)
        
        let label1 = UILabel.init(frame: CGRectMake(65, 10, rect.size.width - 40, rect.size.height / 2))
        label1.text = data.name
        cell?.contentView.addSubview(label1)
        
        customDropdown.normalizeCellText(label1, withSubstring: label1.text)
        if((customDropdown.filterString) != nil)
        {
            customDropdown.highlightedSubstring(customDropdown.filterString, inFilterCellText: label1)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        customDropdown.selectedIndex = UInt.init(bitPattern: indexPath.row)
        customDropdown.isDropDownOpen = false
    }
   
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        
        // Prevent the cell from inheriting the Table View's margin settings.
        cell.preservesSuperviewLayoutMargins = false
        
        // Explictly set cell's layout margins.
        cell.layoutMargins = UIEdgeInsetsZero
    }
}