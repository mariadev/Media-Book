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
    var imageHeight: CGFloat?

    let bookCoverAndDetailStackView = BookCoverAndDetailStackView(imageWidth: 60, imageHeight: 100)
    
    public func update(model: MediaItemDetailProvidable) {

        
        if let url = model.imageURL {
            bookCoverAndDetailStackView.coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
        }
        let bookTitle = model.title
        let creatorName = model.creatorName ?? ""
        
        let desc =  model.description ?? ""
        
        var finalPrice = ""
        
        if let price = model.price {
            finalPrice = ("Buy for \(price)$")
        }
        
        let date =   "Publication Date: \(getDate.dateToString(for: model.creationDate ?? Date()))"
        var finalReview = ""
        if let reviewsUnWrapp = model.numberOfReviews {
            finalReview = "Reviews: \(String(reviewsUnWrapp))"
        }
        
        var finalStars = ""
        
        if let starsUnWrapped = model.rating {
            finalStars = "Rating: \(String(starsUnWrapped))"
        }
        
        bookCoverAndDetailStackView.bookDetails.update(title: bookTitle, author: creatorName, price: finalPrice , date: date, stars: finalStars, reviews: finalReview)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bookCoverAndDetailStackView)
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        bookCoverAndDetailStackView.translatesAutoresizingMaskIntoConstraints = false

        bookCoverAndDetailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bookCoverAndDetailStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bookCoverAndDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bookCoverAndDetailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
    }

}
