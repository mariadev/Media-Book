//
//  MediaItemProvider.swift
//  Media
//
//  Created by Maria on 11/12/2020.
//

import Foundation


class MediaItemProvider {
    
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
            self.init(withMediaItemType: mediaItemType, apiConsumer: MockMedia())
        case .movie:
            self.init(withMediaItemType: mediaItemType, apiConsumer: MockMedia())
  
            
        }
        
    }
    
    func getHomeMediaItems(onSuccess success: @escaping ([MediaItemProvidable])  -> Void, failure: @escaping (Error?) -> Void) {
        
        apiConsumer.getLastestMediaItems(onSuccess: {(mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: {(error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }
}


class MockMedia: MediaItemAPIConsumable {
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let queue = DispatchQueue.global()
        queue.async {
            let mainQueue = DispatchQueue.main
            mainQueue.async {
               failure(nil)
            }
        }
     
    }
    
    
}
