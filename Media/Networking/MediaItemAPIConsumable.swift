//
//  MediaItemApiConsumable.swift
//  Media
//
//  Created by Maria on 11/12/2020.
//

import Foundation

protocol MediaItemAPIConsumable {
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void)
}
