//
//  GoogleBooksAPIConsumer.swift
//  Media
//
//  Created by Maria on 15/12/2020.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {
    
    let session = URLSession.shared
    
      let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes")!
    let apiKey = "AIzaSyBnFh7w0tyJ_D99PDtJpn6zdS3qNkIlgAI"
    
    func getAbsoluteURL(withQueryPArams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let url = getAbsoluteURL(withQueryPArams: ["2019"])
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
