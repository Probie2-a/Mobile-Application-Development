//
//  AdminPage.swift
//  SmithingtonPublicHighSchoolLibrary_CenturaFBLA_SeeversKortz_2018
//
//
//  Created by Colten Seevers & Nick Kortz on 1/29/18.
//  Copyright © 2018 Colten & Nick Kortz. All rights reserved.
//

import UIKit
import SQLite3


class AdminPage: UIViewController
{
    
    
    @IBAction func CreateDatabaseUser(_ sender: Any) {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("UserDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &USER) != SQLITE_OK {
            print("error opening database")
        }
        else{
            print("Database Open")
        }
        
        if sqlite3_exec(USER, "CREATE TABLE IF NOT EXISTS USER (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, userID INTEGER, CObook TEXT, CObarcode INTEGER, COdue TEXT, RESbook TEXT, RESbarcode INTEGER)", nil, nil,nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(USER)!)
            print("error creating table: \(errmsg)")
        }
        else
        {
            print("Table Created")
            
        }
        //USERS
        AddUsers(ID: "2", User: "Amber", Category: "User", Code: "1002", CObook:"", CObarcode: "",COdue: "", RESbook: "",RESbarcode: "")
        AddUsers(ID: "3", User: "James", Category: "User", Code: "1004", CObook: "", CObarcode: "", COdue: "", RESbook: "", RESbarcode: "")
        AddUsers(ID: "4", User: "Peter", Category: "User", Code: "1006", CObook:"", CObarcode: "",COdue: "", RESbook: "",RESbarcode: "")
        AddUsers(ID: "5", User: "Haywood", Category: "User", Code: "1008", CObook:"", CObarcode: "",COdue: "", RESbook: "",RESbarcode: "")
        AddUsers(ID: "6", User: "Jacob", Category: "User", Code: "1010", CObook:"", CObarcode: "",COdue: "", RESbook: "",RESbarcode: "")
        AddUsers(ID: "7", User: "Shell", Category: "User", Code: "1012", CObook:"", CObarcode: "",COdue: "", RESbook: "",RESbarcode: "")
        //ADMINS
        AddUsers(ID: "1", User: "Admin", Category: "Admin", Code: "0001", CObook:"", CObarcode: "",COdue: "", RESbook: "",RESbarcode: "")
        readValues()
        setUpUsers()
        readValues()
    }
}
func AddUsers(ID: String, User:String, Category:String, Code:String, CObook:String, CObarcode:String, COdue:String, RESbook: String,RESbarcode:String){
    
    print(ID,User,Category,Code,CObook,CObarcode,COdue,RESbook,RESbarcode)
    
    
    var stmt:OpaquePointer?
    let queryString = "INSERT INTO USER (name, Category, userID, CObook, CObarcode, COdue, RESbook, RESbarcode) VALUES (?,?,?,?,?,?,?,?)"
    print(queryString)
    if sqlite3_prepare(USER, queryString, -1, &stmt, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("error preparing insert: \(errmsg)")
        return
    }
    
    
    
    if sqlite3_prepare(USER, queryString, -1, &stmt, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("error preparing insert: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(stmt, 1, CurrentUser, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding name: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(stmt, 2, category, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding category: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(stmt, 3, Code, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding ID: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(stmt, 4, CObook, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding CObook: \(errmsg)")
        return
        
    }
    if sqlite3_bind_text(stmt, 5, CObarcode, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding CObarcode: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(stmt, 6, COdue, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding COdue: \(errmsg)")
        return
        
    }
    if sqlite3_bind_text(stmt, 7, RESbook, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding RESbook: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(stmt, 8, RESbarcode, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure binding RESbarcode: \(errmsg)")
        return
    }
    
    if sqlite3_step(stmt) != SQLITE_DONE {
        let errmsg = String(cString: sqlite3_errmsg(USER)!)
        print("failure inserting USER: \(errmsg)")
        return
    }
}
