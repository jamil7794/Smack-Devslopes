//
//  SocketService.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/14/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init(){
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!)
    lazy var socket:SocketIOClient = manager.defaultSocket
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){ //84
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
                completion(true)
            
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
            let user = userDataService.instance
            socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
//    io.emit("messageCreated",  msg.messageBody, msg.userId, msg.channelId, msg.userName, msg.userAvatar, msg.userAvatarColor, msg.id, msg.timeStamp);
    
    func geChatMessage(completion: @escaping CompletionHandler){
        
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else {return}
            guard let ChannelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if ChannelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                
                let newMessage = Message(message: messageBody, userName: userName, channelId: ChannelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }else{
                completion(false)
            }
            
        }
    }
}
