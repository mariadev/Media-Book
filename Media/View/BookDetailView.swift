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

    public func update(model: MediaItemDetailProvidable) {

        if let url = model.imageURL {
            bookCoverAndDetailStackView.coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
        }

        let creatorName = model.creatorName ?? ""

        let desc =  model.description ?? ""

        var finalPrice = ""

        if let price = model.price {
            finalPrice = ("Buy for \(price)$")
        } else {
            bookCoverAndDetailStackView.bookDetails.price.isHidden = true
        }

        let date =   "Publication Date: \(getDate.dateToString(for: model.creationDate ?? Date()))"

        var finalReview = ""

        if let reviewsUnWrapp = model.numberOfReviews {
            finalReview = "Reviews: \(String(reviewsUnWrapp))"
        } else {
            bookCoverAndDetailStackView.bookDetails.reviews.isHidden = true
        }

        var finalStars = ""

        if let starsUnWrapped = model.rating {
            finalStars = "Rating: \(String(starsUnWrapped))"
        } else {
            bookCoverAndDetailStackView.bookDetails.stars.isHidden = true
        }

        title.text = model.title
        bookDescription.text = desc

        bookCoverAndDetailStackView.bookDetails.update(author: creatorName, price: finalPrice, date: date, stars: finalStars, reviews: finalReview)

    }

    public init() {
        super.init(frame: CGRect.zero)
        initialize()
    }

    let buttonFavorite =  UIButton()
    let buttonClose = UIButton()

 let title = UILabel()
   let bookDescription = UILabel()
   let bookCoverAndDetailStackView = BookCoverAndDetailStackView(imageWidth: 116, imageHeight: 180)
    // MARK: - Private
    private let scrollView = UIScrollView()

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
        alignment = .fill
        axis = .vertical
        distribution = .fillProportionally
        isLayoutMarginsRelativeArrangement = true
        spacing = Self.margin
//        alignment = .center
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: Self.margin,
            bottom: 0,
            trailing: Self.margin
        )

    }

    private func layout() {
        scrollView.addSubview(bookDescription)
        scrollView.isScrollEnabled = true

        [buttonClose, title, bookCoverAndDetailStackView, scrollView, buttonFavorite].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        title.numberOfLines = 0
        title.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        title.sizeToFit()
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        bookDescription.numberOfLines = 0
        bookDescription.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        bookCoverAndDetailStackView.bookDetails.alignment = .top
        bookDescription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bookDescription.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        bookDescription.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        bookDescription.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        bookDescription.translatesAutoresizingMaskIntoConstraints = false

        buttonFavorite.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        buttonClose.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        scrollView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

    }

    private func style() {
        backgroundColor = .white

        buttonClose.backgroundColor = Colors.greenSheen
        buttonClose.setTitle("Close", for: .normal)
        buttonClose.setTitleColor(.black, for: .normal)

        buttonFavorite.backgroundColor = Colors.paleGoldenrod
        buttonFavorite.setTitle("Add Favorite", for: .normal)
        buttonFavorite.setTitleColor(.black, for: .normal)
    }
}
