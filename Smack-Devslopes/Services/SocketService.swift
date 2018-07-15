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
}
