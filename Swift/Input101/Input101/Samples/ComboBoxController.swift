//
//  ComboBoxController.swift
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

import UIKit
import XuniInputKit

class ComboBoxController: UIViewController, XuniDropDownDelegate, XuniComboBoxDelegate {

    @IBOutlet weak var comboBoxEdit: XuniComboBox!
    @IBOutlet weak var comboBoxNonEdit: XuniComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.comboBoxEdit.delegate = self
        self.comboBoxEdit.displayMemberPath = "name"
        self.comboBoxEdit.itemsSource = AutoCompleteData.demoData()
        self.comboBoxEdit.dropDownHeight = 200
        self.comboBoxEdit.placeholder = "Please Enter..."
        
        self.comboBoxNonEdit.delegate = self
        self.comboBoxNonEdit.displayMemberPath = "name"
        self.comboBoxNonEdit.itemsSource = AutoCompleteData.demoData()
        self.comboBoxNonEdit.isEditable = false
        self.comboBoxNonEdit.dropDownBehavior = XuniDropDownBehavior.HeaderTap
        self.comboBoxNonEdit.dropDownHeight = 200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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