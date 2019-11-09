//
//  BookSources.swift
//  08.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

class BookSeller {
    class func buyBook(author: String, title: String, stockNumber: Int) -> Book {
        return Book.init(author: author, title: title, stock: stockNumber)
    }
}

class LibraryNetwork {
    class func borrowBook(author: String, title: String, stockNumber: Int) -> Book {
        return Book.init(author: author, title: title, stock: stockNumber)
    }
    
    class func returnBook(book: Book) {
        // do nothing
    }
}
