//
//  Cell.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import UIKit
import SDWebImage

class MediaItemCollectionViewCell: UICollectionViewCell {

    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let title: UILabel = {
        let title = UILabel()
        title.textColor = .darkGray
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "didot", size: 20)
        return title
    }()

    var mediaItem: MediaItemProvidable! {
        didSet {

            if let url = mediaItem.imageURL {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
            } else {
                title.text = mediaItem.title
            }
        }
    }
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, title])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpLayout () {
        contentView.addSubview(verticalStackView)

        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))

    }

}
