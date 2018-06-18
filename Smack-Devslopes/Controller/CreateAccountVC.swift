//
//  CreateAccountVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/18/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: TO_UNWINDTOCHANNEL, sender: nil)
        
    }
}
