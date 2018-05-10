class User {
    let name: String
    let Code: String
    let category: UserType
    let bookList: [Book]
    let reserveList: [Book]
    
    init(name: String, category: UserType, Code: String, bookList: [Book],reserveList: [Book]) {
        self.name = name
        self.category = category
        self.Code = Code
        self.bookList = bookList
        self.reserveList = reserveList
    }
}
