//
//  CustomeTableViewCell.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

final class CustomFavoritesTableViewCell: UITableViewCell {

    let coverImageView = UIImageView()
    var bookTitle = UILabel()
    var creatorName = UILabel()
    var viewWrapper = UIView()
    fileprivate lazy var horizontalStackView = UIStackView(arrangedSubviews: [coverImageView, viewWrapper])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        theme()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update(model: MediaItemDetailProvidable) {

        if let url = model.imageURL {
            coverImageView.sd_setImage(with: url)
        } else {
            coverImageView.image = UIImage(named: "book")
        }

        bookTitle.text = model.title
        creatorName.text = model.creatorName ?? ""

    }
    private func layout() {

        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Margins.separator
        horizontalStackView.distribution = .fillProportionally

        contentView.addSubview(horizontalStackView)

        [creatorName, bookTitle].forEach {
            viewWrapper.addSubview($0)
        }

        [horizontalStackView, bookTitle, creatorName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        coverImageView.widthAnchor.constraint(equalToConstant: Sizes.image).isActive = true
        coverImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        bookTitle.topAnchor.constraint(equalTo: viewWrapper.topAnchor).isActive = true
        bookTitle.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor).isActive = true
        bookTitle.trailingAnchor.constraint(equalTo: viewWrapper.trailingAnchor).isActive = true

        creatorName.topAnchor.constraint(equalTo: bookTitle.bottomAnchor).isActive = true
        creatorName.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor).isActive = true
        creatorName.trailingAnchor.constraint(equalTo: viewWrapper.trailingAnchor).isActive = true

    }

    private func theme() {

        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true

        [ bookTitle, creatorName].forEach {
            $0.font =  UIFont(name: FontFamily.main, size: FontFamily.medium)
            $0.textColor = UIColor.darkGray
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: Margins.small, left: 0, bottom: 0, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
}
