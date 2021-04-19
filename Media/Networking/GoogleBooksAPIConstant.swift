//
//  Constants.swift
//  Media
//
//  Created by Maria on 15/12/2020.
//

import Foundation

struct GoogleBooksAPIConstant {

    private static let apiKey = "AIzaSyBnFh7w0tyJ_D99PDtJpn6zdS3qNkIlgAI"

     static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
         var components = URLComponents()
         components.scheme = "https"
         components.host = "www.googleapis.com"
         components.path = "/books/v1/volumes"
         components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
         components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))

         return components.url!
     }

    static func urlForBook(withId bookId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes/\(bookId)"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]

        return components.url!
    }

    static func getURLByNew() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: "fantasy"))
        components.queryItems?.append(URLQueryItem(name: "orderBy", value: "newest"))
        components.queryItems?.append(URLQueryItem(name: "maxResults", value: "40"))
print( components.url!)
        return components.url!
    }

}
