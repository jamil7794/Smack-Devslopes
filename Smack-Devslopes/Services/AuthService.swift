//
//  AuthService.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/20/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    static let instance = AuthService()
    
     var users = [Users]()
    let defaults = UserDefaults.standard // Dont store password
    
    var isLoggedIn : Bool {
        // i.e. if we are logged in then it will show up in the menu that we are, if we are not , then its gonna say we are not logged in 71
        
        get {
            return defaults.bool(forKey:LOGGED_IN_KEY)
            // check if LOGGED IN KEY exist? true or false 71
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
            // we set the default with the specific key 71
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey:TOKEN_KEY) as! String
 
        }
        set {
            defaults.set(newValue, forKey:TOKEN_KEY)
    
        }
    }
    
    var userEmail : String {
        
        get{
            return defaults.value(forKey:USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){ //71
        let lowerCaseEmail = email.lowercased() //71
    
        let body: [String: Any] = [
            "email":lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString
            {(response) in
            
            if response.result.error == nil {
                completion(true)
            }else{
                completion(true)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){ //71
        let lowerCaseEmail = email.lowercased() //71
        
        let body: [String: Any] = [
            "email":lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(LOGIN_URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON
            {(response) in //73
                
                if response.result.error == nil {
                    
//                    if let json = response.result.value as? Dictionary<String, Any> {
//                        if let email = json["user"] as? String {
//                            self.userEmail = email
//                        }
//                        if let token = json["token"] as? String {
//                            self.authToken = token
//                        }
//                    }
                    
                    guard let data = response.data else {return}
                    let json = try!JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    
                    
                    self.isLoggedIn = true
                    completion(true)
                }else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased() //74
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        
       
        
        Alamofire.request(USER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                let json = try!JSON(data: data)
                let name = json["name"].stringValue
                let email = json["email"].stringValue
                let avatarName = json["avatarName"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                let id = json["_id"].stringValue
                
                userDataService.instance.setUserData(id: id, color: avatarColor, avatarName: avatarName, email: email, name: name)
                
                completion(true)
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){ //81
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding:JSONEncoding.default, headers: BEARER_HEADER).responseJSON{ (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data){ //81
        let json = try!JSON(data: data)
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let id = json["_id"].stringValue
        
        userDataService.instance.setUserData(id: id, color: avatarColor, avatarName: avatarName, email: email, name: name)
    }
    
    func findUserById(ID: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_FIND_USER_BY_ID) \(ID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    func findAllUsers(completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_FIND_USER_BY_ID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {

                guard let data = response.data else {return}
                if let json = try!JSON(data:data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let avatarColor = item["avatarColor"].stringValue
                        let avatarName = item["avatarName"].stringValue
                        let email = item["email"].stringValue
                        let name = item["name"].stringValue
                        
                        let user = Users(id: id, avatarName: avatarName, name: name, avatarColor: avatarColor, email: email)
                        self.users.append(user)
                    }
                    completion(true)
                }
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
    }
}
}
