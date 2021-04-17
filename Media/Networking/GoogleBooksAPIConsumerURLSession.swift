//
//  GoogleBooksAPIConsumer.swift
//  Media
//
//  Created by Maria on 15/12/2020.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {

    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        let url = GoogleBooksAPIConstant.urlForBook(withId: mediaItemId)
        // _, response
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                failure(error)
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let book = try decoder.decode(Book.self, from: data)
                    DispatchQueue.main.async { success(book)}
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }

            } else {
//                DispatchQueue.main.async { success(book) }
            }
        }
        task.resume()
    }

    let session = URLSession.shared

    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let url = GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: ["2021"])
        print(url)
        // _, response
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                failure(error)
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    DispatchQueue.main.async { success(bookCollection.items ?? [])}
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }

            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        task.resume()
    }

    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let paramsList = queryParams.components(separatedBy: " ")

        let url = GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: paramsList)
        // _, response
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                failure(error)
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    DispatchQueue.main.async { success(bookCollection.items ?? [])}
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }

            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        task.resume()
    }

}
