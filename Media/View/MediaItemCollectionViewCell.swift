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
        return title
    }()
    
    
    var mediaItem : MediaItemProvidable! {
        didSet {
            title.text = mediaItem.title
            
            if let url = mediaItem.imageURL {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "book"))
            }
        }
    }
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView,horizontalStackView])
        stack.axis = .vertical
        return stack
    }()
    
    fileprivate lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title])
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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