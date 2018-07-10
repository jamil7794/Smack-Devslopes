//
//  LoginVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/16/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    @IBAction func closePressed(_ sender: Any) { //66
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACC, sender: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) { //80
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userName.text , userName.text != "" else {return }
        guard let pass = userName.text , userName.text != "" else {return }
        
        AuthService.instance.loginUser(email: email, password: pass){ (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.startAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setUpView(){
        spinner.isHidden = true
        userName.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    }
}
