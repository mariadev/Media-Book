////
////  BaseTests.swift
////  BaseTests
////
////  Created by Maria on 10/12/2020.
////
////
////  BookTests.swift
////  MidiaTests
////
////  Created by Julio Martínez Ballester on 2/25/19.
////  Copyright © 2019 Yuju. All rights reserved.
////
//
//import XCTest
//@testable import Media
//
//    class BookTests: XCTestCase {
//
//        let encoder = JSONEncoder()
//        let decoder = JSONDecoder()
//
//        let coverURL = URL(string: "http://books.google.com/books/content?id=qUW5js7ZD7UC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
//        var bestBookEver: Book!
//
//        override func setUp() {
//            super.setUp()
//
//            bestBookEver = Book(bookId: "1", title: "El nombre del viento", authors: ["Patrick Rothfuss"], publishedDate: Date(timeIntervalSinceNow: 13213), description: "Kvothe rules", coverURL: coverURL, rating: 5, numberOfReviews: 2131, price: 10)
//        }
//
//        func testBookExistence() {
//            XCTAssertNotNil(bestBookEver)
//        }
//
//        func testDecodeBookCollection() {
//            guard let path = Bundle(for: type(of: self)).path(forResource: "book-search-response", ofType: "json") else {
//                XCTFail()
//                return
//            }
//
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path))
//                let bookCollection = try decoder.decode(BookCollection.self, from: data)
//                XCTAssertNotNil(bookCollection)
//                let firstBook = bookCollection.items?.first!
//                XCTAssertNotNil(firstBook?.bookId)
//                XCTAssertNotNil(firstBook?.title)
//            } catch {
//                XCTFail()
//            }
//        }
//
//        func testEncodeBook() {
//            do {
//                let bookData = try encoder.encode(bestBookEver)
//                XCTAssertNotNil(bookData)
//            } catch {
//                XCTFail()
//            }
//        }
//
//        func testDecodeEncodedDetailedBook() {
//            do {
//                let bookData = try encoder.encode(bestBookEver)
//                XCTAssertNotNil(bookData)
//                let book = try decoder.decode(Book.self, from: bookData)
//                XCTAssertNotNil(book)
//                XCTAssertNotNil(book.bookId)
//                XCTAssertNotNil(book.title)
//                XCTAssertNotNil(book.authors)
//                XCTAssert(book.authors!.count > 0)
//                XCTAssertNotNil(book.publishedDate)
//                XCTAssertNotNil(book.description)
//                XCTAssertNotNil(book.coverURL)
//                XCTAssertNotNil(book.rating)
//                XCTAssertNotNil(book.numberOfReviews)
//                XCTAssertNotNil(book.price)
//            } catch {
//                XCTFail()
//            }
//        }
//
//        func testPersistOnUserDefaults() {
//            let userDefaults = UserDefaults.init(suiteName: "tests")!
//            let bookKey = "bookKey"
//            do {
//                let bookData = try encoder.encode(bestBookEver)
//                userDefaults.set(bookData, forKey: bookKey)
//                userDefaults.synchronize()
//                if let retrievedBookData = userDefaults.data(forKey: bookKey) {
//                    let decodedBook = try decoder.decode(Book.self, from: retrievedBookData)
//                    XCTAssertNotNil(decodedBook)
//                } else {
//                    XCTFail()
//                }
//            } catch {
//                XCTFail()
//            }
//        }
//
//    }
//
//
