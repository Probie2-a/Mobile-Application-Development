//
//  Search.swift
//  FBLA5
//
//  Created by Colten Seevers & Nick Kortz on 2/5/18.
//  Copyright © 2018 Colten & Nick. All rights reserved.
//

import UIKit
import SQLite3

class Search: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var db: OpaquePointer?
   // var stmt: OpaquePointer?
    var BookList = [Book]()
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var tableViewBooks: UITableView!
    @IBOutlet weak var textFieldBarcode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("BookDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Save(_ sender: Any) {
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let barcode = textFieldBarcode.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(barcode?.isEmpty)!{
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        var stmt: OpaquePointer?
        
        let queryString = "INSERT INTO Book (name, book) VALUES (?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding book: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 2, (barcode! as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding book: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting book: \(errmsg)")
            return
        }
        
        textFieldName.text=""
        textFieldBarcode.text=""
        
        readValues()
        
        print("Book saved successfully")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let book: Book
        book = BookList[indexPath.row]
        cell.textLabel?.text = book.name
        return cell
    }
    
    
    func readValues(){
        BookList.removeAll()
        
        let queryString = "SELECT * FROM Books"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let barcode = sqlite3_column_int(stmt, 2)
            
            BookList.append(Book(id: Int(id), name: String(describing: name), barcode: Int(barcode)))
        }
        
        self.tableViewBooks.reloadData()
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


