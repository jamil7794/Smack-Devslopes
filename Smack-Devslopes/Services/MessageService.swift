//
//  MessageService.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 7/10/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var c = ""
    
    func findAllChannels(completion: @escaping CompletionHandler){ //81
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                if let json = try!JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["desription"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    completion(true)
                }

            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
}
