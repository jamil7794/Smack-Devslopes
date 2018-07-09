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
    @IBOutlet weak var loginBtn: UIButton!

    @IBAction func prepareforUnwind(segue: UIStoryboardSegue){}
    
    @IBOutlet weak var userImg: CircleImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            // Whenever we create an account the notification is posted. this function obsevers the notification when it is posted then it performs a task when we logout, all the variables will be equal to empty setrings or false
    }

    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification){ //78
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(userDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: userDataService.instance.avatarName)
            userImg.backgroundColor = userDataService.instance.returnUIColor(components: userDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
}
