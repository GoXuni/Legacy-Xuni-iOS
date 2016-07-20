//
//  MaskedInputController.swift
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

import Foundation
import XuniInputKit

class MaskedInputController: UIViewController {
    
    @IBOutlet weak var maskedID: XuniMaskedTextField!
    @IBOutlet weak var maskedDOB: XuniMaskedTextField!
    @IBOutlet weak var maskedPhone: XuniMaskedTextField!
    @IBOutlet weak var maskedState: XuniMaskedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.maskedID.mask = "000-00-0000"
        self.maskedDOB.mask = "90/90/0000"
        self.maskedPhone.mask = "(999) 000-0000"
        self.maskedState.mask = "LL"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
