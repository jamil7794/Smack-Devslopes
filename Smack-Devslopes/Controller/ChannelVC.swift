//
//  ChannelVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/12/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    static let instance = ChannelVC()
    @IBOutlet weak var loginBtn: UIButton?
    @IBAction func prepareforUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       loginBtn?.setTitle("\(userDataService.instance.name)", for: .normal)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
