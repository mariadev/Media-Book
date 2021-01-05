//
//  DetailViewControllerLayout.swift
//  Media
//
//  Created by Maria on 19/12/2020.
//

import UIKit
import SDWebImage


public final class BookDetailView: UIStackView {
    
    
    let getDate = SetDate()
    
    static let margin: CGFloat = 16
    static let coverSize = CGSize(width: 119, height: 180)
    
    public func update(model: MediaItemDetailProvidable) {
        
        if let url = model.imageURL {
            bookCoverAndDetailStackView.coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
        }
        
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
        
        title.text = model.title
        bookDescription.text = desc
        
        bookCoverAndDetailStackView.bookDetails.update(author: creatorName, price: finalPrice  , date: date, stars: finalStars, reviews: finalReview)
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    let buttonPreview =  UIButton()
    let buttonClose = UIButton()
    
    // MARK: - Private
    
    private let title = UILabel()
    private let bookDescription = UILabel()
    private let bookCoverAndDetailStackView = BookCoverAndDetailStackView()
    
    
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
        isLayoutMarginsRelativeArrangement = true
        spacing = Self.margin
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Self.margin,
            leading: Self.margin,
            bottom: Self.margin,
            trailing: Self.margin
        )
        bookCoverAndDetailStackView.spacing = Self.margin
        
    }
    
    private func layout() {
        [buttonClose, title, bookCoverAndDetailStackView, bookDescription, buttonPreview].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        title.numberOfLines = 0
        title.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        title.textAlignment = .center
        title.sizeToFit()
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        bookDescription.numberOfLines = 0
        bookDescription.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        
        buttonPreview.setTitle("Add Favorite", for: .normal)
        buttonPreview.setTitleColor(.black, for: .normal)
        buttonPreview.contentHorizontalAlignment = .center
        buttonPreview.center = self.center
        
        buttonClose.setTitle("Close", for: .normal)
        buttonClose.setTitleColor(.black, for: .normal)
        buttonClose.titleLabel?.textAlignment = .center

    }
    
    private func style() {
        backgroundColor = .white
    }
}

private final class BookCoverAndDetailStackView: UIStackView {
    
    static let margin: CGFloat = 16
    static let coverSize = CGSize(width: 119, height: 180)
    
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    // MARK: - Private
    let coverImageView = UIImageView()
    let bookDetails = BookDetailsStackView()
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        configure()
        layout()
    }
    
    private func configure() {
        alignment = .top
        axis = .horizontal
        distribution = .fill
    }
    
    private func layout() {
        [coverImageView, bookDetails].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.widthAnchor.constraint(equalToConstant: Self.coverSize.width).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: Self.coverSize.height).isActive = true
    }
    
}

/// Book  author, description. Subview of BookStackView.
 private final class BookDetailsStackView: UIStackView {
    
    func update( author: String, price: String, date: String, stars: String, reviews: String) {
        self.author.text = author
        self.price.text = price
        self.date.text = date
        self.stars.text = stars
        self.reviews.text = reviews
    }
    
    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }
    
    // MARK: - Private
    
    private let author = UILabel()
    private let price = UILabel()
    private let date = UILabel()
    private let reviews = UILabel()
    private let stars = UILabel()
    
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
        distribution = .fillEqually
        author.numberOfLines = 0
        date.numberOfLines = 0
        [author, price, date, stars, reviews].forEach {
            ($0).numberOfLines = 0
        }
    }
    
    private func layout() {
        [author, date, stars, reviews, price].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func style() {
        author.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        [price, date, stars, reviews].forEach {
            ($0).font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        }
    }
}
