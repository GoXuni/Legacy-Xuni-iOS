//
//  GroupingController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class GroupingController: UIViewController {
    var _flex = FlexGrid()
    var _sortAscendingButton = UIButton()
    var _sortDescendingButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _flex.autoGenerateColumns = false
        let c1: FlexColumn = FlexColumn()
        c1.binding = "firstName"
        c1.header = NSLocalizedString("First Name", comment: "")
        c1.width = 100
        let c2: FlexColumn = FlexColumn()
        c2.binding = "lastName"
        c2.header = NSLocalizedString("Last Name", comment: "")
        let c3: FlexColumn = FlexColumn()
        c3.binding = "orderTotal"
        c3.header = NSLocalizedString("Order Total", comment: "")
        c3.format = "C"
        c3.aggregate = XuniAggregate.Sum
        _flex.columns.addObject(c1)
        _flex.columns.addObject(c2)
        _flex.columns.addObject(c3)


        // Do any additional setup after loading the view.
        _sortAscendingButton = UIButton(type: UIButtonType.System)
        _sortAscendingButton.setTitle(NSLocalizedString("Ascending", comment: ""), forState: UIControlState.Normal)
        _sortAscendingButton.addTarget(self, action: "sortAscendingButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        _sortDescendingButton = UIButton(type: UIButtonType.System)
        _sortDescendingButton.setTitle(NSLocalizedString("Descending", comment: ""), forState: UIControlState.Normal)
        _sortDescendingButton.addTarget(self, action: "sortDescendingButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        _flex.itemsSource = CustomerData.getCustomerData(100)
        _flex.isReadOnly = true
        
        let gd = XuniPropertyGroupDescription(property: "country")
        let sd = XuniSortDescription(property: "country", ascending: true)
        
        _flex.collectionView.groupDescriptions.addObject(gd)
        _flex.collectionView.sortDescriptions.addObject(sd)
        
        self.starSizing(_flex)
        self.view.addSubview(_flex)
        self.view.addSubview(_sortDescendingButton)
        self.view.addSubview(_sortAscendingButton)
    }
    
    func starSizing(g: FlexGrid) {
        for var i:UInt = 0; i < g.columns.count; i++ {
            let c: FlexColumn = g.columns.objectAtIndex(i) as! FlexColumn
            c.widthType = FlexColumnWidth.Star
            c.width = (i == 0) ? 3 : (i == 3) ? 3 : 4
        }
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
        let sd = XuniSortDescription(property: "country", ascending: true)
        _flex.collectionView.sortDescriptions.addObject(sd)
    }
    
    func sortDescendingButtonClicked(){
        _flex.collectionView.sortDescriptions.removeAllObjects()
        let sd = XuniSortDescription(property: "country", ascending: false)
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
