//
//  StorageManager.swift
//  Media
//
//  Created by Maria on 30/12/2020.
//

import Foundation

final class StorageManager {

    static var shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .book)

    static func setup(withMediaItemKind mediaItemKind: MediaItemType) {
        shared = CoreDataStorageManager(withMediaItemKind: mediaItemKind)
    }

}
