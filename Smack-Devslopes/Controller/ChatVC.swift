//
//  ChatVC.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/12/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    // Variabels
    var typing  = false
    
    @IBOutlet weak var messageTxtBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        sendBtn.isHidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        view.bindToKeyboard() // the entire view shifts up
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap) // Dismiss the keyboard when we press the view
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // Adding a view controller on the top left. We use the function SWrevealViewController.receal togggle from RevealViewCOntroller. 64
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // Sliding left and right between toggle and main view .64
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)) , name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn { //80
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        SocketService.instance.geChatMessage { (success) in
            if success{
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let indIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indIndex, at: .bottom, animated: false)
                }
            }
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessage()
            channelNameLbl.text = "Smack"
        }else{
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    func onLoginGetMessage(){
        MessageService.instance.findAllChannels { (success) in
            if MessageService.instance.channels.count > 0 {
                // setting the first channel(newChannel)
                MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                self.updateWithChannel()
            }else{
                self.channelNameLbl.text = "No Channel yet!"
            }
        }
    }
    
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channelID: channelId) { (sucess) in
            if sucess  {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        // Showiein when other users are typing
        if messageTxtBox.text == "" {
            typing = false
            sendBtn.isHidden = true
        }else {
            if typing == false {
                sendBtn.isHidden = false
            }
            typing = true
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxtBox.text else {return}
            SocketService.instance.addMessage(messageBody: message, userId: userDataService.instance.id, channelId: channelId) { (success) in
                self.messageTxtBox.text = ""
                self.messageTxtBox.resignFirstResponder() // Dismiss the keyboard
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? messageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}
