//
//  SelectionModesController.swift
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexGridKit

class SelectionModesController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var _selectionModePicker = UIPickerView()
    var _flex = FlexGrid()
    var _pickerData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _pickerData = [NSLocalizedString("None", comment: ""), NSLocalizedString("Cell", comment: ""), NSLocalizedString("Cell Range", comment: ""), NSLocalizedString("Row", comment: ""), NSLocalizedString("Row Range", comment: "")]
        
        _flex.isReadOnly = true
        _flex.itemsSource = CustomerData.getCustomerData(100)
        
        _selectionModePicker.delegate = self
        _selectionModePicker.showsSelectionIndicator = true
        _selectionModePicker.hidden = false
        
        self.view.addSubview(_flex)
        self.view.addSubview(_selectionModePicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _flex.frame = CGRectMake(0, 206, self.view.bounds.size.width, (self.view.bounds.size.height-206))
        _selectionModePicker.frame = CGRectMake(self.view.bounds.size.width/4, 44, self.view.bounds.size.width/2, 162)
        _flex.setNeedsDisplay()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return _pickerData.count
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (row) {
        case 0:
            _flex.selectionMode = FlexSelectionMode.None
        case 1:
            _flex.selectionMode = FlexSelectionMode.Cell
        case 2:
            _flex.selectionMode = FlexSelectionMode.CellRange
        case 3:
            _flex.selectionMode = FlexSelectionMode.Row
        case 4:
            _flex.selectionMode = FlexSelectionMode.RowRange
        default:
            break;
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return _pickerData.objectAtIndex(row) as? String
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
