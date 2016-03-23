//
//  FilterFormController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit

class FilterFormController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var _pickerData = NSMutableArray()
    var _filterField = UITextField()
    var _filterPicker = UIPickerView()
    var _filterButton = UIButton()
    
    let sharedData = SharedFilterData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkStartingFilterValues()

        // Do any additional setup after loading the view.
        _pickerData = [NSLocalizedString("Contains", comment: ""), NSLocalizedString("Begins with", comment: ""), NSLocalizedString("Ends with", comment: ""), NSLocalizedString("Equals", comment: "")]
        
        _filterPicker.delegate = self
        _filterPicker.showsSelectionIndicator = true
        _filterPicker.hidden = false
        
        _filterButton = UIButton(type: UIButtonType.System)
        _filterButton.setTitle(NSLocalizedString("Filter", comment: ""), forState: UIControlState.Normal)
        _filterButton.addTarget(self, action: "filterButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        _filterButton.titleLabel?.textAlignment = NSTextAlignment.Center
        _filterButton.backgroundColor = UIColor.blueColor()
        _filterButton.tintColor = UIColor.whiteColor()
        
        _filterField.delegate = self
        _filterField.returnKeyType = UIReturnKeyType.Done
        _filterField.keyboardType = UIKeyboardType.Default
        _filterField.backgroundColor = UIColor.lightGrayColor()

        self.view.addSubview(_filterField)
        self.view.addSubview(_filterPicker)
        self.view.addSubview(_filterButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _filterField.frame = CGRectMake(self.view.bounds.size.width/4, 65, self.view.bounds.size.width/2, 50)
        _filterPicker.selectRow(self.sharedData.filterOperation, inComponent: 0, animated: false)
        _filterPicker.frame = CGRectMake(self.view.bounds.size.width/2 - 160, 100, 320, 162)
        _filterButton.frame = CGRectMake(self.view.bounds.size.width/4, 300, self.view.bounds.size.width/2, 50)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

    }
    
    func checkStartingFilterValues(){
        
        if(self.sharedData.filterOperation == nil){
            self.sharedData.filterOperation = 0;
        }
        if(self.sharedData.filterString != nil && self.sharedData.filterString != ""){
            _filterField.text = self.sharedData.filterString
        }
        else{
            _filterField.text = NSLocalizedString("Enter text to Filter",comment:"")
        }
    }
    func filterButtonClicked(){
        self.sharedData.filterSet = true
        self.sharedData.filterString = _filterField.text
        navigationController?.popViewControllerAnimated(true)
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.sharedData.filterOperation = row
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return _pickerData.objectAtIndex(row) as! String
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.selectAll(nil)
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.sharedData.filterString = textField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
