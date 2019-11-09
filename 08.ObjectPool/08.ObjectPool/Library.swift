//
//  Library.swift
//  08.ObjectPool
//
//  Created by wdy on 2019/11/8.
//  Copyright © 2019 wdy. All rights reserved.
//

import Foundation

final class Library {
    private let pool: Pool<Book>
    
    private init(stockLevel: Int) {
        let stockId: Int = 1
        
        self.pool = Pool<Book>.init(itemCount: stockLevel, itemFactory: { () -> Book in
            return BookSeller.buyBook(author: "Dickens, Charles", title: "Hard Times", stockNumber: stockId+1)
        }, itemAllocator: { (books) -> Int in
            var selected = 0
            for index in 1..<books.count {
                if books[index].checkoutCount < books[selected].checkoutCount {
                    selected = index
                }
            }
            return selected
        })
    }
    
    private class var singleton: Library {
        struct SingletonWrapper {
            static let singleton = Library.init(stockLevel: 5)
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
        singleton.pool.processPoolItems { (books) in
            for book in books {
                print("...Book#\(book.stockNumber)...")
                print("Checked out \(book.checkoutCount) times")
                if book.reader != nil {
                    print("Checked out to \(book.reader!)")
                } else {
                    print("In stock")
                }
            }
            print("There are \(books.count) books in the pool")
        }
    }
}
