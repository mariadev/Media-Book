//
//  BookCollection.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import Foundation

struct BookCollection {
    let kind: String
    let totalItems: Int
    let items: [Book]?

}

extension BookCollection: Decodable {

}
