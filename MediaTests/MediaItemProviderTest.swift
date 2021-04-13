//
//  MediaItemProviderTest.swift
//  MediaTests
//
//  Created by Maria on 16/12/2020.
//

import XCTest
@testable import Media

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {

    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        failure(nil)
    }

    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                success([MockMediaItem(), MockMediaItem()])
            }
        }
    }

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        success([MockMediaItem(), MockMediaItem()])
    }

}

struct MockMediaItem: MediaItemProvidable {
    var mediaItemId: String = "1"
    var title: String = "A title"
    var imageURL: URL?
}

class MediaItemProviderTests: XCTestCase {

    var mediaItemProvider: MediaItemProvider!
    var mockConsumer = MockMediaItemAPIConsumer()

    override func setUp() {
        super.setUp()

        mediaItemProvider = MediaItemProvider(withMediaItemType: .book, apiConsumer: mockConsumer)
    }

    func testGetHomeMediaItems() {
        mediaItemProvider.getHomeMediaItems(onSuccess: { (mediaItems) in
            XCTAssertNotNil(mediaItems)
            XCTAssert(!mediaItems.isEmpty)
            XCTAssertNotNil(mediaItems.first?.title)
        }) { (_) in XCTFail("Fail") }
    }

}
