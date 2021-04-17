//
//  CustomeTableViewCell.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

class CustomFavoritesTableViewCell: UITableViewCell {

    let coverImageView = UIImageView()
    var bookTitle = UILabel()
    var creatorName = UILabel()
    var viewWrapper = UIView()

    fileprivate lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [coverImageView, viewWrapper])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        return stack
    }()

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
            coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
        }

        bookTitle.text = model.title
        creatorName.text = model.creatorName ?? ""

    }
    private func layout() {
        contentView.addSubview(horizontalStackView)
        viewWrapper.addSubview(creatorName)
        viewWrapper.addSubview(bookTitle)

        coverImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        coverImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.topAnchor.constraint(equalTo: viewWrapper.topAnchor).isActive = true
        bookTitle.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor).isActive = true
        bookTitle.trailingAnchor.constraint(equalTo: viewWrapper.trailingAnchor).isActive = true

        creatorName.topAnchor.constraint(equalTo: bookTitle.bottomAnchor).isActive = true
        creatorName.translatesAutoresizingMaskIntoConstraints = false
        creatorName.leadingAnchor.constraint(equalTo: viewWrapper.leadingAnchor).isActive = true
        creatorName.trailingAnchor.constraint(equalTo: viewWrapper.trailingAnchor).isActive = true

    }

    private func theme() {
        contentView.backgroundColor = .white

        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true

        [ bookTitle, creatorName].forEach {
            $0.font =  UIFont(name: "didot", size: 16)
            $0.textColor = UIColor.darkGray
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}
