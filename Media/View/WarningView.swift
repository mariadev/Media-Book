//
//  WarningView.swift
//  Media
//
//  Created by Maria on 18/12/2020.
//

import UIKit

final class WarningView: UIView {
    
    private  lazy var stackFailureEmoji:  UIStackView = {
        let stack = UIStackView(arrangedSubviews: [failureEmoji, failureEmojiText])
        addSubview(stack)
        stack.axis = .vertical
        return stack
        
    }()
    
    
    private let failureEmoji : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    private let failureEmojiText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         initialize()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     private func initialize() {
         layout()
         applyTheme()
     }
    

    private func layout() {
        [self, failureEmoji, failureEmojiText, stackFailureEmoji].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            stackFailureEmoji.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackFailureEmoji.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func applyTheme() {
         backgroundColor = .orange
         failureEmoji.font = UIFont.systemFont(ofSize: 30)
         failureEmojiText.font = UIFont.systemFont(ofSize: 30)
         stackFailureEmoji.backgroundColor = .white
     }
    
    func update(state: MediaItemViewControllerState) {
        switch state {
        case .noResults:
            isHidden = false
            failureEmoji.text = "😞"
            failureEmojiText.text = "No Results"
        case .failure:
            isHidden = false
            failureEmojiText.text = "Conexion Error"
            failureEmoji.text = "❌"
        default:
            isHidden = true
        }
    }
}

