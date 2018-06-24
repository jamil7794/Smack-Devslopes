//
//  AuthService.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/20/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import Foundation
import Alamofire

class AuthService{
    static let instance = AuthService()
    
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
        
        get {
            return defaults.value(forKey:USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){ //71
        let lowerCaseEmail = email.lowercased() //71
        
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email":lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString
            {(response) in
            
            if response.result.error == nil {
                completion(true)
            }else{
                completion(true)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
}
