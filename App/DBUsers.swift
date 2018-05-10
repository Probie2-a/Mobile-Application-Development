//
//  DBUsers.swift
//  SQLiteApp
//
//  Created by Someone on 3/28/16.
//
//

import SQLite

class DBUsers {
    
    private let DBUser = Table("DBUser")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let category = Expression<String>("category")
    private let userID = Expression<String>("userID")
    private let UserStatus = Expression<String>("UserStatus")
    
    static let instance = DBUsers()
    private let db: Connection?
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/DBUsers.sqlite3")
            createTable()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func createTable() {
        do {
            try db!.run(DBUser.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(category)
                table.column(userID, unique: true)
                table.column(UserStatus)
                
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addDBUser(cname: String, ccategory: String, cuserID: String, cUserStatus: String) {
        do {
            let insert = DBUser.insert(name <- cname, category <- ccategory, userID <- cuserID, UserStatus <- cUserStatus)
            let id = try db!.run(insert)
            
            //return id
        } catch {
            print("Insert failed")
          //  return nil
        }
    }

    func getDBUser() -> [DBAccounts] {
        var DBUser = [DBAccounts]()
        
        do {
            for DBAccounts in try db!.prepare(self.DBUser) {
                DBUser.append(DBAccounts(
                    id: DBAccounts[id],
                    name: DBAccounts[name]!,
                    category:DBAccounts[category],
                    userID: DBAccounts[userID],
                UserStatus: DBAccounts[UserStatus]))
            }
        } catch {
            print("Select failed")
        }
        
        return DBUser
    }
    
    func deleteDBUser(cid: Int64) -> Bool {
        do {
            let DBAccounts = DBUser.filter(id == cid)
            try db!.run(DBAccounts.delete())
            return true
        } catch {
            
            print("Delete failed")
        }
        return false
    }
    
    func updateDBUser(cid:Int64, newDBUser: DBUser) -> Bool {
        let DBAccounts = DBUser.filter(id == cid)
        do {
            let update = DBAccounts.update([
                name <- newDBUser.name,
                category <- newDBUser.category,
                userID <- newDBUser.userID
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
}

