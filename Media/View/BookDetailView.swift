//
//  DetailViewControllerLayout.swift
//  Media
//
//  Created by Maria on 19/12/2020.
//

import UIKit
import SDWebImage

public final class BookDetailView: UIView {

    let getDate = SetDate()
    static let margin: CGFloat = 16

    let buttonFavorite =  UIButton()
    let buttonClose = UIButton()

    let title = UILabel()
    var bookDescription = UILabel()
    let coverImageView = UIImageView()
    var creatorName = UILabel()
    var  finalPrice = UILabel()
    var  finalReview  = UILabel()
    var  finalStars = UILabel()
    var date = UILabel()
    let wrapperLabel = UIView()

    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [coverImageView, verticalStackView ])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()

    fileprivate lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [creatorName, finalPrice, date, finalReview, finalStars ])
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()

    private let scrollView = UIScrollView()

    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        layout()
        style()
    }

    public func update(model: MediaItemDetailProvidable) {

        if let url = model.imageURL {
            coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
        }

        creatorName.text = model.creatorName ?? ""

        let desc =  model.description ?? ""

        if let price = model.price {
            finalPrice.text = ("Buy for \(price)$")
        } else {
            finalPrice.isHidden = true
        }

        date.text = "Publication Date: \(getDate.dateToString(for: model.creationDate ?? Date()))"

        if let reviewsUnWrapp = model.numberOfReviews {
            finalReview.text = "Reviews: \(String(reviewsUnWrapp))"
        } else {
            finalReview.isHidden = true
        }

        if let starsUnWrapped = model.rating {
            finalStars.text = "Rating: \(String(starsUnWrapped))"
        } else {
            finalStars.isHidden = true
        }

        title.text = model.title
        //        bookDescription.text = desc
    }

    private func layout() {
        scrollView.addSubview( bookDescription)

        [buttonClose, title, horizontalStackView, scrollView, buttonFavorite].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }

        buttonClose.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        title.topAnchor.constraint(equalTo: buttonClose.bottomAnchor, constant: 20).isActive = true

        horizontalStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20).isActive = true

        scrollView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor).isActive = true
        scrollView.isScrollEnabled = true

        bookDescription.translatesAutoresizingMaskIntoConstraints = false
        bookDescription.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        bookDescription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bookDescription.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        bookDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        buttonFavorite.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        buttonFavorite.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        bookDescription.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bookDescription.heightAnchor.constraint(equalToConstant: 200).isActive = true

    }

    private func style() {

        title.frame = title.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
        backgroundColor = .white

        title.numberOfLines = 0
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.font =  UIFont(name: "didot", size: 30)

        buttonClose.titleLabel?.font =  UIFont(name: "didot", size: 30)
        buttonClose.backgroundColor = Colors.brokeWhite
        buttonClose.setTitle("Close", for: .normal)
        buttonClose.setTitleColor(.darkGray, for: .normal)

        [creatorName, finalPrice, date, finalReview, finalStars, title ].forEach {
            $0.textColor = UIColor.darkGray
        }
        
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
        coverImageView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        coverImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        bookDescription.numberOfLines = 0
        bookDescription.lineBreakMode = .byWordWrapping
        bookDescription.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bookDescription.font = UIFont(name: "didot", size: 15)
        bookDescription.textColor = UIColor.darkGray

        buttonFavorite.titleLabel?.font = UIFont(name: "didot", size: 30)
        buttonFavorite.backgroundColor = Colors.brokeWhite
        buttonFavorite.setTitle("Add Favorite", for: .normal)
        buttonFavorite.setTitleColor(.black, for: .normal)
    }
}
