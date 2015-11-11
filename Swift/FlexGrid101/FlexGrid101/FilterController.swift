//
//  FilterController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit
import Foundation

class FilterController: UIViewController {
    
    var _flex = FlexGrid()
    var _filterButton = UIButton()
    var _removeButton = UIButton()
    let sharedData = SharedFilterData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _filterButton = UIButton(type: UIButtonType.System) 
        _filterButton.setTitle("Filter", forState: UIControlState.Normal)
        _filterButton.addTarget(self, action: "filterButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        _removeButton = UIButton(type: UIButtonType.System)
        _removeButton.setTitle("Remove", forState: UIControlState.Normal)
        _removeButton.addTarget(self, action: "removeButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        _flex.isReadOnly = true
        _flex.itemsSource = CustomerData.getCustomerData(100)
        
        self.view.addSubview(_flex)
        self.view.addSubview(_removeButton)
        self.view.addSubview(_filterButton)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _filterButton.frame = CGRectMake(0, 60, self.view.bounds.size.width/2, 50)
        _removeButton.frame = CGRectMake(self.view.bounds.size.width/2, 60, self.view.bounds.size.width/2, 50)
        _flex.frame = CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-110)
        _flex.setNeedsDisplay()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        let filterSet = SharedFilterData.sharedInstance.filterSet
        
        if (filterSet != nil && filterSet == true) {
            
            if (self.sharedData.filterOperation == 0) {
                self.containsFilter()
            }
            else if (self.sharedData.filterOperation == 1){
                self.beginsWithFilter()
            }
            else if (self.sharedData.filterOperation == 2){
                self.endsWithFilter()
            }
            else if (self.sharedData.filterOperation == 3){
                self.equalsFilter()
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        self.sharedData.filterSet = false
        self.sharedData.filterString = ""
        self.sharedData.filterOperation = 0
    }
    
    func filterButtonClicked(){
        self.performSegueWithIdentifier("FilterFormSegue", sender: self)
    }
    func containsFilter(){
        var dateFormat = NSDateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("M/d/yy")
        _flex.collectionView.filter = {(item : NSObject?) -> Bool in
            var d = item as! CustomerData
            
            if (String(format: "%.f", d.customerID).rangeOfString(self.sharedData.filterString) != nil) {
                return true
            }
            else if (String(format: "%.f", d.countryID).rangeOfString(self.sharedData.filterString) != nil) {
                return true
            }
            else if (String(format: "%.f", d.orderTotal).rangeOfString(self.sharedData.filterString.lowercaseString) != nil) {
                return true
            }
            else if (d.firstName.lowercaseString.rangeOfString(self.sharedData.filterString.lowercaseString) != nil) {
                return true
            }
            else if (d.lastName.lowercaseString.rangeOfString(self.sharedData.filterString.lowercaseString) != nil)
            {
                return true
            }
            else if (d.city.lowercaseString.rangeOfString(self.sharedData.filterString.lowercaseString) != nil){
                return true
            }
            else if (d.address.lowercaseString.rangeOfString(self.sharedData.filterString.lowercaseString) != nil){
                return true
            }
            else if (d.country.lowercaseString.rangeOfString(self.sharedData.filterString.lowercaseString) != nil){
                return true
            }
            else if (dateFormat.stringFromDate(d.lastOrderDate).rangeOfString(self.sharedData.filterString.lowercaseString) != nil) {
                return true
            }
            else {
                return false
            }
        } as IXuniPredicate
    }
    
    func equalsFilter(){
        var dateFormat = NSDateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("M/d/yy")
        _flex.collectionView.filter = {(item : NSObject?) -> Bool in
            var d = item as! CustomerData
            
            if (String(format: "%.f", d.customerID) == self.sharedData.filterString) {
                return true
            }
            else if (String(format: "%.f", d.countryID) == self.sharedData.filterString) {
                return true
            }
            else if (String(format: "%.f", d.orderTotal) == self.sharedData.filterString) {
                return true
            }
            else if (d.firstName == self.sharedData.filterString) {
                return true
            }
            else if (d.lastName == self.sharedData.filterString)
            {
                return true
            }
            else if (d.city == self.sharedData.filterString){
                return true
            }
            else if (d.address == self.sharedData.filterString){
                return true
            }
            else if (d.country == self.sharedData.filterString){
                return true
            }
            else if (dateFormat.stringFromDate(d.lastOrderDate) == self.sharedData.filterString) {
                return true
            }
            else {
                return false
            }
        } as IXuniPredicate
    }
    func endsWithFilter(){
        var dateFormat = NSDateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("M/d/yy")
        _flex.collectionView.filter = {(item : NSObject?) -> Bool in
            var d = item as! CustomerData
            
            if (String(format: "%.f", d.customerID).hasSuffix(self.sharedData.filterString)) {
                return true
            }
            else if (String(format: "%.f", d.countryID).hasSuffix(self.sharedData.filterString)) {
                return true
            }
            else if (String(format: "%.f", d.orderTotal).hasSuffix(self.sharedData.filterString)) {
                return true
            }
            else if (d.firstName.lowercaseString.hasSuffix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else if (d.lastName.lowercaseString.hasSuffix(self.sharedData.filterString.lowercaseString)){
                return true
            }
            else if (d.city.lowercaseString.hasSuffix(self.sharedData.filterString.lowercaseString)){
                return true
            }
            else if (d.address.hasSuffix(self.sharedData.filterString.lowercaseString)){
                return true
            }
            else if (d.country.lowercaseString.hasSuffix(self.sharedData.filterString.lowercaseString)){
                return true
            }
            else if (dateFormat.stringFromDate(d.lastOrderDate).hasSuffix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else {
                return false
            }
        } as IXuniPredicate
    }
    func beginsWithFilter(){
        var dateFormat = NSDateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("M/d/yy")
        _flex.collectionView.filter = {(item : NSObject?) -> Bool in
            var d = item as! CustomerData
            
            if (String(format: "%.f", d.customerID).hasPrefix(self.sharedData.filterString)) {
                return true
            }
            else if (String(format: "%.f", d.countryID).hasPrefix(self.sharedData.filterString)) {
                return true
            }
            else if (String(format: "%.f", d.orderTotal).hasPrefix(self.sharedData.filterString)) {
                return true
            }
            else if (d.firstName.lowercaseString.hasPrefix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else if (d.lastName.lowercaseString.hasPrefix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else if (d.city.lowercaseString.hasPrefix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else if (d.address.lowercaseString.hasPrefix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else if (d.country.lowercaseString.hasPrefix(self.sharedData.filterString.lowercaseString)) {
                return true
            }
            else if (dateFormat.stringFromDate(d.lastOrderDate).hasPrefix(self.sharedData.filterString)) {
                return true
            }
            else {
                return false
            }
            return false
        } as IXuniPredicate
    }
    func removeButtonClicked(){
        self.sharedData.filterSet = false
        self.sharedData.filterString = ""
        self.sharedData.filterOperation = 0
        _flex.collectionView.filter = {(item : NSObject?) -> Bool in
            return true
        }
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
