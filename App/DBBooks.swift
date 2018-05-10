class DBBooks {
    let id: Int64?
    var name: String
    var barcode: String
    var category: BookType
    var bookStatus: String
    
    init(id: Int64) {
        self.id = id
        name = ""
        barcode = ""
        category = BookType.cat
        bookStatus = ""
    }
    
    init(id: Int64, name: String, barcode: String, category: BookType, bookStatus: String) {
        self.id = id
        self.name = name
        self.barcode = barcode
        self.category = category
        self.bookStatus = bookStatus
    }
    
}
