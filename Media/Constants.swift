//
//  Constants.swift
//  Media
//
//  Created by Maria on 15/12/2020.
//

import Foundation

struct GoogleBooksAPIConstant {
    
    private static let apiKey = "AIzaSyBnFh7w0tyJ_D99PDtJpn6zdS3qNkIlgAI"
     
     static func getAbsoluteURL(withQueryPArams queryParams: [String]) -> URL {
         var components = URLComponents()
         components.scheme = "https"
         components.host = "www.googleapis.com"
         components.path = "/books/v1/volumes"
         components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
         components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
         
         return components.url!
     }
}
