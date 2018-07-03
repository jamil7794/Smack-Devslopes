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
// colors
let smackPurplePlaceHolder = #colorLiteral(red: 0.3254901961, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)

//Notifications
let NOTIF_USER_DATA_DID_CHANGE
 = Notification.Name("NotifyuserDataCHange")
