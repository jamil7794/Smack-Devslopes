//
//  LoginVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/16/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    static let instance = LoginVC()

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    @IBOutlet weak var email: UITextField!
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
        
        guard let eMail = email.text , email.text != "" else {return }
        guard let pass = password.text , password.text != "" else {return }
        
        AuthService.instance.loginUser(email: eMail, password: pass){ (success) in
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
        email.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    }
}
