//
//  UserDefaultStorageManager.swift
//  Media
//
//  Created by Maria on 30/12/2020.
//

import Foundation

class UserDefaultStorageManager: FavoritesProvidable {

    let userDefaults = UserDefaults.standard
    let favoritesKey: String
    let mediaItemType: MediaItemType

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init(withMediaItemType mediaItemType: MediaItemType) {
        self.mediaItemType = mediaItemType
        self.favoritesKey = "favorite\(mediaItemType)"
    }

    func getFavorites() -> [MediaItemDetailProvidable]? {
        if let favoritesData = userDefaults.data(forKey: favoritesKey) {
            switch mediaItemType {
            case .book:
                return try? decoder.decode([Book].self, from: favoritesData)
            default:
                fatalError("Media kind `\(mediaItemType)` not supported yet")
            }
        }
        return nil
    }

    func getFavorite(byId favoriteId: String) -> MediaItemDetailProvidable? {
        var retrieved: MediaItemDetailProvidable?
        if let favorites = getFavorites() {
            retrieved = favorites.filter({ $0.mediaItemId == favoriteId }).first
        }
        return retrieved
    }

    func add(favorite: MediaItemDetailProvidable) {
        guard getFavorite(byId: favorite.mediaItemId) == nil else {
            return
        }
        if var favorites = getFavorites() {
            favorites.append(favorite)
            save(favorites)
        } else {
            save([favorite])
        }
    }

    func remove(favoriteWithId favoriteId: String) {
        if var favorites = getFavorites() {
            for (index, favorite) in favorites.enumerated() where favoriteId == favorite.mediaItemId {
                favorites.remove(at: index)
                save(favorites)
            }
        }
    }

    private func save(_ favorites: [MediaItemDetailProvidable]) {
        do {
            switch mediaItemType {
            case .book:
                userDefaults.set(try encoder.encode(favorites as! [Book]), forKey: favoritesKey)
            default:
                fatalError("not supported yet")
            }
            userDefaults.synchronize()
        } catch {
            fatalError("error enconding favorites")
        }
    }
}
