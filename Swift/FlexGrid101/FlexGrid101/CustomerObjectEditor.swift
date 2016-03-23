import Foundation
import UIKit
import XuniFlexGridKit

class CustomerObjectEditor: UITableViewController {
    
    
    @IBOutlet weak var firstNameEdit: UITextField!
    @IBOutlet weak var secondNameEdit: UITextField!
    @IBOutlet weak var countryEdit: UITextField!
    @IBOutlet weak var cityEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var addressEdit: UITextField!
    
    func initObject() {
        self.firstNameEdit.text = edited.firstName
        self.secondNameEdit.text = edited.lastName
        self.countryEdit.text = edited.country
        self.cityEdit.text = edited.city
        self.addressEdit.text = edited.address
        self.emailEdit.text = edited.email
        self.firstNameEdit.placeholder = firstNameEdit.text
        self.secondNameEdit.placeholder = secondNameEdit.text
        self.countryEdit.placeholder = countryEdit.text
        self.cityEdit.placeholder = cityEdit.text
        self.addressEdit.placeholder = addressEdit.text
        self.emailEdit.placeholder = emailEdit.text
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        objEdit = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 2 {
            efc.cancel()
        }
        else {
            if indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 3
            {
                edited.firstName = objEdit.firstNameEdit.text!
                edited.lastName = objEdit.secondNameEdit.text!
                edited.country = objEdit.countryEdit.text!
                edited.city = objEdit.cityEdit.text!
                edited.address = objEdit.addressEdit.text!
                edited.email = objEdit.emailEdit.text!
                efc.confirm()
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    @IBAction func endEdit(sender: AnyObject) {
        resignFirstResponder()
    }
}

var objEdit: CustomerObjectEditor! = nil