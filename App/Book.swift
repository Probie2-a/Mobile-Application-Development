class Book {
    let name: String
    let barcode: String
    let category: BookType
    let status: StatusType
    let duedate: String
    
    init() {
        self.name = ""
        self.category = .fiction
        self.barcode = ""
        self.status = .available
        self.duedate = ""
    }
    init(name: String, category: BookType, barcode: String, status: StatusType, duedate: String) {
        self.name = name
        self.category = category
        self.barcode = barcode
        self.status = status
        self.duedate = duedate
    }
}
