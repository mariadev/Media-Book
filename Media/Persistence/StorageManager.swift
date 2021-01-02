//
//  StorageManager.swift
//  Media
//
//  Created by Maria on 30/12/2020.
//

import Foundation


class StorageManager {

    static var shared : FavoritesProvidable = UserDefaultStorageManager(withMediaItemType: .book)

//    static func setup(withMediaItemKind mediaItemKind: MediaItemType) {
//        shared = CoreDataStorageManager(withMediaItemKind: mediaItemKind)
//    }

}
