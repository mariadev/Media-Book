//
//  DateFormater.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import Foundation

extension DateFormatter {
    
    static let booksAPIDateFromarter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
}

