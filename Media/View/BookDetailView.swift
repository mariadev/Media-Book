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
    static let margin: CGFloat = FontFamily.medium

    let buttonFavorite =  UIButton()
    let buttonClose = UIButton()

    let title = UILabel()
    var bookDescription = UILabel()
    let coverImageView = UIImageView()
    var creatorName = UILabel()
    var finalPrice = UILabel()
    var finalReview  = UILabel()
    var finalStars = UILabel()
    var date = UILabel()
    let wrapperLabel = UIView()
    let scrollView = UIScrollView()

    lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [coverImageView, verticalStackView ])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = Margins.separator
        stack.distribution = .fill
        return stack
    }()

    fileprivate lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [creatorName, finalPrice, date, finalReview, finalStars ])
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()

    init() {
        super.init(frame: CGRect.zero)
        initialize()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        layout()
        theme()
    }

    public func update(model: MediaItemDetailProvidable) {

        if let url = model.imageURL {
            coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
        }

        creatorName.text = model.creatorName ?? ""

        guard let desc = model.description else { return }
        bookDescription.text =  desc.html2String

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
    }

    private func layout() {

        wrapperLabel.addSubview(bookDescription)
        scrollView.addSubview( wrapperLabel)

        [buttonClose, title, horizontalStackView, scrollView, buttonFavorite].forEach {
            addSubview($0)

        }

        [buttonClose, title, horizontalStackView, scrollView, wrapperLabel, bookDescription, buttonFavorite].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        buttonClose.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonClose.heightAnchor.constraint(equalToConstant: Sizes.button).isActive = true
        buttonClose.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonClose.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        title.topAnchor.constraint(equalTo: buttonClose.bottomAnchor, constant: Margins.large).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.large).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins.large).isActive = true

        horizontalStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Margins.large).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.large).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins.large).isActive = true

        scrollView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: Margins.large).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.large).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins.large).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: buttonFavorite.bottomAnchor).isActive = true

        wrapperLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        wrapperLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        wrapperLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        wrapperLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        wrapperLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        wrapperLabel.heightAnchor.constraint(equalTo: bookDescription.heightAnchor, constant: Margins.extraLarge).isActive = true

        bookDescription.topAnchor.constraint(equalTo: wrapperLabel.topAnchor).isActive = true
        bookDescription.leadingAnchor.constraint(equalTo: wrapperLabel.leadingAnchor).isActive = true
        bookDescription.trailingAnchor.constraint(equalTo: wrapperLabel.trailingAnchor).isActive = true

        buttonFavorite.heightAnchor.constraint(equalToConstant: Sizes.button).isActive = true
        buttonFavorite.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonFavorite.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttonFavorite.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins.large).isActive = true

    }

    private func theme() {
        backgroundColor = .white

        title.numberOfLines = 0
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.font =  UIFont(name: FontFamily.main, size: FontFamily.extraLarge)

        buttonClose.titleLabel?.font = UIFont(name: FontFamily.main, size: FontFamily.extraLarge)
        buttonClose.backgroundColor = Colors.brokeWhite
        buttonClose.setTitle(ButtonName.top, for: .normal)
        buttonClose.setTitleColor(.darkGray, for: .normal)

        [creatorName, finalPrice, date, finalReview, finalStars, title ].forEach {
            $0.textColor = UIColor.darkGray
        }
        
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
        coverImageView.widthAnchor.constraint(equalToConstant: Sizes.imageLarge).isActive = true
        coverImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        bookDescription.numberOfLines = 0
        bookDescription.lineBreakMode = .byWordWrapping
        bookDescription.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bookDescription.font = UIFont(name: FontFamily.main, size: FontFamily.medium)
        bookDescription.textColor = UIColor.darkGray

        buttonFavorite.titleLabel?.font = UIFont(name: FontFamily.main, size: FontFamily.extraLarge)
        buttonFavorite.backgroundColor = Colors.brokeWhite
        buttonFavorite.setTitle(ButtonName.bottomType1, for: .normal)
        buttonFavorite.setTitleColor(.black, for: .normal)
    }
}
