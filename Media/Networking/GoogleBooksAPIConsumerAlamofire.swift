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
        AF.request(GoogleBooksAPIConstant.getAbsoluteURL(withQueryPArams: ["Heathcliff"])).responseData { (response) in
            
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

