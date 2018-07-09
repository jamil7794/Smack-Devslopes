//
//  ProfileVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/9/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        userDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        // Notify that user data did change. Userdata service has empty or false varibles
        dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){
            userEmail.text = userDataService.instance.email
            userName.text = userDataService.instance.name
            profileImg.image = UIImage(named: userDataService.instance.avatarName)
            profileImg.backgroundColor = userDataService.instance.returnUIColor(components: userDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
