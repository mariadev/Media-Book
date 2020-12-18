//
//  GoogleBooksAPIConsumerAlamofire.swift
//  Media
//
//  Created by Maria on 16/12/2020.
//

import Foundation
import Alamofire

class GoogleBooksAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        AF.request(GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: ["2020"])).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case . success( let value):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: value)
                    success(bookCollection.items ?? [])
                } catch {
                    failure(error)
                }
            }
        }
    }
    
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let paramsList = queryParams.components(separatedBy: " ")
        AF.request(GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: paramsList)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case . success( let value):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: value)
                    success(bookCollection.items ?? [])
                } catch {
                    failure(error)
                }
            }
        }
        
    }
}

