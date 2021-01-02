//
//  DetailViewControllerLayout.swift
//  Media
//
//  Created by Maria on 19/12/2020.
//

import UIKit
import SDWebImage


final class DetailViewControllerLayout: UIStackView {
    
    let getDate = SetDate()
    
    var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var mediaItem : MediaItemDetailProvidable! {
        didSet {
            bookTitle.text = mediaItem.title
            
            if let url = mediaItem.imageURL {
                coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
            }
            
            author.text = mediaItem.creatorName
            
            textDescription.text = mediaItem.description
            date.text =   "Publication Date: \(getDate.dateToString(for: mediaItem.creationDate ?? Date()))"
            if let reviewUnWrapped = mediaItem.rating {
                stars.text = "Rating: \(String(reviewUnWrapped))"
            } else {
                stars.isHidden = true
            }
            
            if let reviewsUnWrapp = mediaItem.numberOfReviews {
                reviews.text = "Reviews: \(String(reviewsUnWrapp))"
            } else {
                reviews.isHidden = true
            }
            
            if let price = mediaItem.price {
                buttonBuy.setTitle("Buy for \(price)$", for: .normal)
            } else {
                buttonBuy.isHidden = true
            }
            
        }
    }
    
    let bookTitle: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.text = "Big Title"
        title.sizeToFit()
        title.textColor = .darkGray
        title.numberOfLines = 0
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return title
    }()
    
    let author: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let reviews: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let stars: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let textDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let buttonClose: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let buttonBuy: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let buttonPreview: UIButton = {
        let button = UIButton()
        button.setTitle("Add Favorite", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            buttonClose,
            bookTitle,
            bookStackView,
            textDescription,
            buttonPreview
        ])
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var bookStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [coverImageView, bookDetailsStackView])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 16.0
        return stack
    }()
    
    private lazy var bookDetailsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            author,
            stars,
            reviews,
            date,
            buttonBuy
        ])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    func setUpLayout () {
        
        [
            self,
            buttonClose,
            stackView,
            bookDetailsStackView,
            bookStackView,
            bookTitle,
            coverImageView,
            textDescription,
            bookDetailsStackView,
            textDescription,
            buttonPreview
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
//        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
        coverImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        coverImageView.backgroundColor = .systemGreen

//
////        middleChildVerticalInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
////        middleChildContainerInfoStackView.leadingAnchor.constraint(equalTo: middleChildVerticalInfoStackView.leadingAnchor, constant: 10).isActive = true
////        middleChildContainerInfoStackView.trailingAnchor.constraint(equalTo: middleChildVerticalInfoStackView.trailingAnchor, constant: -10).isActive = true
//
////        middleParentHorizontalInfoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
////        middleParentHorizontalInfoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//
//        textDescription.topAnchor.constraint(equalTo: middleParentHorizontalInfoStackView.bottomAnchor).isActive = true
//        textDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
//        textDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
//
//        buttonClose.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        buttonClose.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        buttonClose.heightAnchor.constraint(equalToConstant: 26).isActive = true
//
//        buttonPreview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        buttonPreview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        buttonPreview.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        buttonPreview.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        textDescription.backgroundColor = .brown
        author.backgroundColor = .darkGray
        buttonPreview.backgroundColor = .green
        buttonClose.backgroundColor = .green
        
    }
    
}

