//
//  CustomeTableViewCell.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let getDate = SetDate()
    
    static let margin: CGFloat = 16
    static let coverSize = CGSize(width: 119, height: 180)

    let bookDetailView = BookDetailView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bookDetailView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

