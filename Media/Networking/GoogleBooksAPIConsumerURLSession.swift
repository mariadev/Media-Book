//
//  GoogleBooksAPIConsumer.swift
//  Media
//
//  Created by Maria on 15/12/2020.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {
    let session = URLSession.shared
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let url = GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: ["occult"])
        let task = session.dataTask(with: url) { (data, response, error) in
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
        
        let task = session.dataTask(with: url) { (data, response, error) in
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

