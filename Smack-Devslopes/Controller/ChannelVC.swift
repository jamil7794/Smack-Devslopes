//
//  ChannelVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/12/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var findAllUsers: RoundedButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareforUnwind(segue: UIStoryboardSegue){}

    
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            // Whenever we create an account the notification is posted. this function obsevers the notification when it is posted then it performs a task when we logout, all the variables will be equal to empty setrings or false. i.e.  Radios and broadcast
         NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        SocketService.instance.getChannel { (success) in
            self.tableView.reloadData()
        }
        
        SocketService.instance.geChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannel.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
        AuthService.instance.findAllUsers { (success) in
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) { //80
        setUpUserInfo()
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
        setUpUserInfo()
    }
    
    func setUpUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(userDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: userDataService.instance.avatarName)
            userImg.backgroundColor = userDataService.instance.returnUIColor(components: userDataService.instance.avatarColor)
            findAllUsers.isHidden = false
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            findAllUsers.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.confifureCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//85
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        
        if MessageService.instance.unreadChannel.count > 0 {
            MessageService.instance.unreadChannel = MessageService.instance.unreadChannel.filter{$0 != channel.id} // Take out the chennelId that we pressed
        }
        
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        NotificationCenter.default.post(name: NOTIF_CHANNELS_SELECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
    }
    @IBAction func addChannelVC(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    
    @objc func channelsLoaded(_ notif: Notification){
        self.tableView.reloadData()
    }
}
