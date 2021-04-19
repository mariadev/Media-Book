//
//  Cell.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import UIKit
import SDWebImage

final class MediaItemCollectionViewCell: UICollectionViewCell {

    fileprivate let imageView = UIImageView()
    let title = UILabel()
    let verticalView = UIView()

    var mediaItem: MediaItemProvidable! {
        didSet {
            title.text = mediaItem.title
            if let url = mediaItem.imageURL {
                imageView.sd_setImage(with: url)
            } else {
                imageView.image = UIImage(named: "book")
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        theme()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpLayout() {

        contentView.addSubview(verticalView)

        [title, imageView].forEach {
            verticalView.addSubview($0)
        }

        [verticalView, title, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        verticalView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: verticalView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: verticalView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Sizes.imageExtraLarge).isActive = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)

        title.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: verticalView.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: verticalView.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: verticalView.bottomAnchor).isActive = true
    }

    func theme() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        title.textColor = .darkGray
        title.numberOfLines = 0
        title.minimumScaleFactor = 0.5
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont(name: FontFamily.main, size: FontFamily.small)
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: Margins.small, left: Margins.medium, bottom: Margins.small, right: Margins.medium))

    }

}
