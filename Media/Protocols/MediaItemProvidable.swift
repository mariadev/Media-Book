//
//  MediaItemProvider.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import Foundation

protocol MediaItemProvidable {

    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }

}
