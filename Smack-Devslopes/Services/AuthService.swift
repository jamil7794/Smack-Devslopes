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
        // i.e. if we are logged in then it will show up in the menu that we are, if we are not , then its gonna say we are not logged in 71
        
        get {
            return defaults.value(forKey:TOKEN_KEY) as! String
            // check if LOGGED IN KEY exist? 71
        }
        set {
            defaults.set(newValue, forKey:TOKEN_KEY)
            // we set the default with the specific key
        }
    }
    
    var userEmail : String {
        // i.e. if we are logged in then it will show up in the menu that we are, if we are not , then its gonna say we are not logged in
        
        get {
            return defaults.value(forKey:USER_EMAIL) as! String
            // check if LOGGED IN KEY exist?
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
            // we set the default with the specific key 71
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let header = [
            "Conetent Type":"application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email":lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString{(response) in
            
            if response.result.error == nil {
                completion(true)
            }else{
                completion(true)
                debugPrint(response.result.error as any)
            }
        }
    }
    
    
    
}
