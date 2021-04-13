//
//  Game.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import Foundation

struct Game: MediaItemProvidable {
    let title: String = "A game"
    let imageURL: URL? = nil
    var mediaItemId: String {
        return ""
    }
}
