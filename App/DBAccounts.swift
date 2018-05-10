//
//  DBAccounts.swift
//  FBLA5
//
//  Created by Kenley on 2/12/18.
//  Copyright © 2018 Kenley. All rights reserved.
//

import Foundation

class DBAccounts {
    let id: Int64?
    var name: String
    var category: UserType
    var userID: String
    var UserStatus : String
    
    
    init(id: Int64) {
        self.id = id
        name = ""
        category = UserType.user
        userID = ""
        UserStatus = ""
    }
    
    init(id: Int64, name: String, category: UserType, userID: String, UserStatus: String) {
        self.id = id
        self.name = name
        self.category = category
        self.userID = userID
        self.UserStatus = UserStatus
    }
    
}

