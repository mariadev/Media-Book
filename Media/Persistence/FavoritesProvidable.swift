//
//  FavoritesProvidable.swift
//  Media
//
//  Created by Maria on 30/12/2020.
//

import Foundation

protocol FavoritesProvidable {
    
    func getFavorites() -> [MediaItemDetailProvidable]?
    func getFavorite(byId favoriteId: String) -> MediaItemDetailProvidable?
    func add(favorite: MediaItemDetailProvidable)
    func remove(favoriteWithId: String)
}
