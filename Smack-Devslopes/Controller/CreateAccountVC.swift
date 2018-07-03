//
//  CreateAccountVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/18/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    // variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: userDataService.instance.avatarName)
            avatarName = userDataService.instance.avatarName
        }
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: TO_UNWINDTOCHANNEL, sender: nil)
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATARPICKER, sender: nil)
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = usernameTxt.text , usernameTxt.text != "" else {return}
        guard let email = emailTxt.text , emailTxt.text != "" else {return} // , means denotes where guard is another way of unwrapping because email is a string
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
//                        print("logged in user!", AuthService.instance.authToken) //73
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (sucess) in
                            if success {
                                print(userDataService.instance.name, userDataService.instance.avatarName)
                                self.performSegue(withIdentifier: TO_UNWINDTOCHANNEL, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
}
