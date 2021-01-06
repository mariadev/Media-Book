//
//  BookBaseView.swift
//  Media
//
//  Created by Maria on 05/01/2021.
//

import UIKit

final class BookCoverAndDetailStackView: UIStackView {
    
    let margin: CGFloat = 16
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    
    init(imageWidth: CGFloat, imageHeight: CGFloat) {
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    let coverImageView = UIImageView()
    let bookDetails = BookDetailsStackView()
    
    
    private func initialize() {
        configure()
        layout()
    }
    
    private func configure() {
        alignment = .top
        axis = .horizontal
        distribution = .fill
        spacing = self.margin
        bookDetails.spacing = self.margin
    }
    
    private func layout() {
        [coverImageView, bookDetails].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        let coverSize = CGSize(width: imageWidth, height: imageHeight)
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.widthAnchor.constraint(equalToConstant: coverSize.width).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: coverSize.height).isActive = true
    }
    
}

/// Book  author, description. Subview of BookStackView.
final class BookDetailsStackView: UIStackView {
    
    func update( author: String, price: String, date: String, stars: String, reviews: String) {
        self.author.text = author
        self.price.text = price
        self.date.text = date
        self.stars.text = stars
        self.reviews.text = reviews
        
        [self.date, self.stars, self.reviews].forEach {
            $0.isHidden = false
        }
    }
    
    func update(title: String, author: String, price: String, date: String, stars: String, reviews: String) {
        self.title.text = title
        self.author.text = author
        self.price.text = price
        
        [self.date, self.stars, self.reviews].forEach {
            $0.isHidden = true
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    // MARK: - Private
    private let title = UILabel()
    let author = UILabel()
    let price = UILabel()
    let date = UILabel()
    let reviews = UILabel()
    let stars = UILabel()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        configure()
        layout()
        style()
    }
    
    private func configure() {
        alignment = .top
        axis = .vertical
        distribution = .fill
    }
    
    private func layout() {
        [title,author, date, stars, reviews, price].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            ($0).numberOfLines = 0
        }
    }
    
    private func style() {
        [ title, author].forEach {
            ($0).font =  UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        }
        [price, date, stars, reviews].forEach {
            ($0).font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        }
    }
}
