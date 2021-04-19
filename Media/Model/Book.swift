//
//  Book.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import Foundation

struct Book {

    let bookId: String
    let title: String
    let authors: [String]?
    let publishedDate: Date?
    let description: String?
    let coverURL: URL?
    let rating: Float?
    let review: Int?
    let price: Float?

    init(bookId: String, title: String, authors: [String]? = nil, publishedDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, rating: Float? = nil,
         numberOfReviews: Int, price: Float? = nil) {
        self.bookId = bookId
        self.title = title
        self.authors = authors
        self.publishedDate = publishedDate
        self.description = description
        self.coverURL = coverURL
        self.rating = rating
        self.review.self = numberOfReviews
        self.price = price
    }

}

extension Book: Codable {

    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case volumeInfo
        case title
        case authors
        case publishedDate
        case description
        case imageLinks
        case coverURL = "thumbnail"
        case rating = "averageRating"
        case numberOfReviews = "ratingsCount"
        case saleInfo
        case listPrice
        case price = "amount"
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        //        bookId = try container.decode(String.self, forKey: CodingKeys.bookId)
        bookId = try container.decode(String.self, forKey: .bookId)

        let volumeInfo = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)

        title = try volumeInfo.decode(String.self, forKey: .title)

        authors = try volumeInfo.decodeIfPresent([String].self, forKey: .authors)
        description = try volumeInfo.decodeIfPresent(String.self, forKey: .description)
        
        if let publishedDateString = try volumeInfo.decodeIfPresent(String.self, forKey: .publishedDate) {
            publishedDate = DateFormatter.booksAPIDateFormater.date(from: publishedDateString)
        } else {
            publishedDate = nil
        }

        let imageLinkContainer = try? volumeInfo.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)

        coverURL = try imageLinkContainer?.decodeIfPresent(URL.self, forKey: .coverURL)
        rating = try volumeInfo.decodeIfPresent(Float.self, forKey: .rating)
        review = try volumeInfo.decodeIfPresent(Int.self, forKey: .numberOfReviews)

        let saleInfoContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        let listPriceContainer = try? saleInfoContainer?.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        price = try listPriceContainer?.decodeIfPresent(Float.self, forKey: .price)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(bookId, forKey: .bookId)

        var volumeInfoContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        try volumeInfoContainer.encode(title, forKey: .title)
        try volumeInfoContainer.encodeIfPresent(authors, forKey: .authors)
        if let date = publishedDate {
            try volumeInfoContainer.encode(DateFormatter.booksAPIDateFormater.string(from: date), forKey: .publishedDate)
        }
        try volumeInfoContainer.encodeIfPresent(description, forKey: .description)

        var imageLinksContainer = volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
        try imageLinksContainer.encodeIfPresent(coverURL, forKey: .coverURL)

        try volumeInfoContainer.encodeIfPresent(rating, forKey: .rating)
        try volumeInfoContainer.encodeIfPresent(numberOfReviews, forKey: .numberOfReviews)

        var saleInfoContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        var listPriceContainer = saleInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        try listPriceContainer.encodeIfPresent(price, forKey: .price)

    }

}

extension Book: MediaItemProvidable {

    var mediaItemId: String {
        return bookId
    }

    var imageURL: URL? {
        return coverURL
    }

}

extension Book: MediaItemDetailProvidable {

    var creatorName: String? {
        return  authors?.joined(separator: ", ")
    }

    var numberOfReviews: Int? {
        return review
    }

    var creationDate: Date? {
        return publishedDate
    }

}
