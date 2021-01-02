//
//  CustomeTableViewCell.swift
//  Media
//
//  Created by Maria on 29/12/2020.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let getDate = SetDate()
    
    fileprivate let imageViewTable: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        return title
    }()
    
    let author: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let buttonBuy: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    var mediaItem : MediaItemDetailProvidable! {
        didSet {
            title.text = mediaItem.title
            
            if let url = mediaItem.imageURL {
                imageViewTable.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
            }
            
            author.text = mediaItem.creatorName
            
            date.text =   "Publication Date: \(getDate.dateToString(for: mediaItem.creationDate ?? Date()))"
            
            if let price = mediaItem.price {
                buttonBuy.setTitle("Buy for \(price)$", for: .normal)
            } else {
                buttonBuy.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewTable.sd_cancelCurrentImageLoad()
        [buttonBuy].forEach({ $0?.isHidden = false })
    }
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageViewTable,horizontalStackView])
        stack.axis = .vertical
        return stack
    }()
    
    fileprivate lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, author, date, buttonBuy])
        stack.axis = .horizontal
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyTheme()
        setUpLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyTheme () {
        
        title.textColor = .darkGray
        title.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        
    }
    
    func setUpLayout () {
        contentView.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.heightAnchor.constraint(equalToConstant: 26).isActive = true
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4))
        
    }
    
}
