//
//  GroupingController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexGridKit

class GroupingController: UIViewController {
    var _flex = FlexGrid()
    var _sortAscendingButton = UIButton()
    var _sortDescendingButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _sortAscendingButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        _sortAscendingButton.setTitle("Ascending", forState: UIControlState.Normal)
        _sortAscendingButton.addTarget(self, action: "sortAscendingButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        _sortDescendingButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        _sortDescendingButton.setTitle("Descending", forState: UIControlState.Normal)
        _sortDescendingButton.addTarget(self, action: "sortDescendingButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.isReadOnly = true
        
        var gd = XuniPropertyGroupDescription(property: "last")
        var sd = XuniSortDescription(property: "last", ascending: true)
        
        _flex.collectionView.groupDescriptions.addObject(gd)
        _flex.collectionView.sortDescriptions.addObject(sd)
        
        self.view.addSubview(_flex)
        self.view.addSubview(_sortDescendingButton)
        self.view.addSubview(_sortAscendingButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _sortAscendingButton.frame = CGRectMake(0, 60, self.view.bounds.size.width/2, 50)
        _sortDescendingButton.frame = CGRectMake(self.view.bounds.size.width/2, 60, self.view.bounds.size.width/2, 50)
        _flex.frame = CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-110)
        
        _flex.setNeedsDisplay()
    }
    
    func sortAscendingButtonClicked(){
        _flex.collectionView.sortDescriptions.removeAllObjects()
        var sd = XuniSortDescription(property: "last", ascending: true)
        _flex.collectionView.sortDescriptions.addObject(sd)
    }
    
    func sortDescendingButtonClicked(){
        _flex.collectionView.sortDescriptions.removeAllObjects()
        var sd = XuniSortDescription(property: "last", ascending: false)
        _flex.collectionView.sortDescriptions.addObject(sd)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
