//
//  CustomerObjectEditor.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//
import UIKit
class CustomerObjectEditor: UITableViewController {
    func initObject() {
        let efc: EditingFormController = (self.parentViewController as! EditingFormController)
        self.firstNameEdit.text = efc.edited.firstName
        self.secondNameEdit.text = efc.edited.lastName
        self.countryEdit.text = efc.edited.country
        self.cityEdit.text = efc.edited.city
        self.addressEdit.text = efc.edited.address
        self.emailEdit.text = efc.edited.email
        self.firstNameEdit.placeholder = self.firstNameEdit.text!
        self.secondNameEdit.placeholder = self.secondNameEdit.text!
        self.countryEdit.placeholder = self.countryEdit.text!
        self.cityEdit.placeholder = self.cityEdit.text!
        self.addressEdit.placeholder = self.addressEdit.text!
        self.emailEdit.placeholder = self.emailEdit.text!
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let efc: EditingFormController = (self.parentViewController as! EditingFormController)
        if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 2 {
            efc.cancel()
        }
        else if indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 3 {
            efc.edited.firstName = self.firstNameEdit.text!
            efc.edited.lastName = self.secondNameEdit.text!
            efc.edited.country = self.countryEdit.text!
            efc.edited.city = self.cityEdit.text!
            efc.edited.address = self.addressEdit.text!
            efc.edited.email = self.emailEdit.text!
            efc.confirm()
        }

        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    @IBAction func endEdit(sender: AnyObject) {
        self.resignFirstResponder()
    }

    @IBOutlet weak var firstNameEdit: UITextField!
    @IBOutlet weak var secondNameEdit: UITextField!
    @IBOutlet weak var countryEdit: UITextField!
    @IBOutlet weak var cityEdit: UITextField!
    @IBOutlet weak var addressEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
}
//
//  CustomerObjectEditor.m
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//