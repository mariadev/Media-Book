//
//  SetDate.swift
//  Base
//
//  Created by Maria on 10/12/2020.
//


import Foundation

struct SetDate {
    
    func stringToDate (for date:String) -> Date {
        let stringDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let getDate = dateFormatter.date(from: stringDate)
        guard let releaseDate = getDate
        else {
            fatalError()
        }
        return releaseDate
    }
    
    func dateToString (for date:Date) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
