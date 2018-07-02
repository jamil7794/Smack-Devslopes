//
//  Constants.swift
//  Smack-Devslopes
//
//  Created by Jamil Jalal on 6/16/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import Foundation
typealias CompletionHandler = (_ Success: Bool) ->()// Creating a clsoure: We are going to send a web request, wheneverthe web request is done, we are going to complete it by calling this true or false 71
var LOGGED_IN = false
//URL Constants
let BASE_URL =  "https://hellohello1.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let LOGIN_URL_REGISTER = "\(BASE_URL)account/login"
let USER_URL = "\(BASE_URL)user/add"

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACC = "toCreateAccount"
let TO_UNWINDTOCHANNEL = "unwindToChannel"
let TO_AVATARPICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// HEADERS
let HEADER = [
    "Content-Type":"application/json; charset=utf-8"
    
]
