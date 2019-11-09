//
//  Library.swift
//  07.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation


final class Library {
    private var books: [Book]
    private let pool: Pool<Book>
    
    private init(stockLevel: Int) {
        books = [Book].init()
        for count in 0...stockLevel {
            books.append(Book.init("Dickens, Carles", "Hard Times", count))
        }
        pool = Pool<Book>(items: books)
    }
    
    private class var singleton: Library {
        struct SingletonWrapper {
            static let singleton = Library.init(stockLevel: 2)
        }
        return SingletonWrapper.singleton
    }
    
    class func checkoutBook(reader: String) -> Book? {
        let book = singleton.pool.getFromPool()
        book?.reader = reader
        book?.checkoutCount += 1
        return book
    }
    
    class func returnBook(book: Book) {
        book.reader = nil
        singleton.pool.returnToPool(item: book)
    }
    
    class func printReport() {
        for book in singleton.books {
            print("...Book#\(book.stockNumber)...")
            print("Checked out \(book.checkoutCount) times")
            if book.reader != nil {
                print("Checked out to \(book.reader!)")
            } else {
                print("In stock")
            }
        }
    }
    
}
