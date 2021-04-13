//
//  MediaItemDetailProvidable.swift
//  Media
//
//  Created by Maria on 23/12/2020.
//

import Foundation

public protocol MediaItemDetailProvidable {

    var title: String { get }
    var imageURL: URL? { get }
    var creatorName: String? { get }
    var rating: Float? { get }
    var numberOfReviews: Int? { get }
    var creationDate: Date? { get }
    var price: Float? { get }
    var description: String? { get}
    var mediaItemId: String { get }

}
