//
//  MediaItemProvider.swift
//  Media
//
//  Created by Maria on 11/12/2020.
//

import Foundation

final class MediaItemProvider {

    let mediaItemType: MediaItemType
    let apiConsumer: MediaItemAPIConsumable

    init(withMediaItemType mediaItemType: MediaItemType, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemType = mediaItemType
        self.apiConsumer = apiConsumer
    }

    convenience init(withMediaItemType mediaItemType: MediaItemType) {

        switch mediaItemType {
        case .book:
            self.init(withMediaItemType: mediaItemType, apiConsumer: GoogleBooksAPIConsumerURLSession())
        case .game:
            self.init(withMediaItemType: mediaItemType, apiConsumer: GoogleBooksAPIConsumerAlamofire())
        case .movie:
            self.init(withMediaItemType: mediaItemType, apiConsumer: GoogleBooksAPIConsumerAlamofire())

        }

    }

    func getHomeMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        apiConsumer.getLastestMediaItems(onSuccess: {(mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: {(error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }

    func getSearchMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {

        apiConsumer.getMediaItems(withQueryParams: queryParams, success: {(mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: {(error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }

    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailProvidable) -> Void, failure: @escaping (Error?) -> Void) {

        apiConsumer.getMediaItem(byId: mediaItemId, success: {(mediaItemId) in
            assert(Thread.current == Thread.main)
            success(mediaItemId)
        }, failure: {(error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })

    }

}
