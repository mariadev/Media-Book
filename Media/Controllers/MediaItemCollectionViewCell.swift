//
//  Cell.swift
//  Media
//
//  Created by Maria on 10/12/2020.
//

import UIKit

class MediaItemCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage! {
        didSet {
            imageView.image = image
            imageView.clipsToBounds = true
        }
    }
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let title: UILabel = {
            let title = UILabel()
            title.textColor = .darkGray
            title.font = UIFont.systemFont(ofSize: 10, weight: .bold)
            return title
        }()
    

    var mediaItem : MediaItemProvidable! {
        didSet {
        title.text = mediaItem.title
        image = UIImage(named: "image4")
        }
    }
    


    fileprivate lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView,horizontalStackView])
        stack.axis = .vertical
        return stack
    }()
    
    fileprivate lazy var horizontalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(verticalStackView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        horizontalStackView.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4))
        
    }
    
}
