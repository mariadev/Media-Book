//
//  WarningView.swift
//  Media
//
//  Created by Maria on 18/12/2020.
//

import UIKit

final class WarningView: UIView {

    private lazy var stackFailureEmoji = UIStackView(arrangedSubviews: [failureEmoji, failureEmojiText])

    private let failureEmoji = UILabel()

    private let failureEmojiText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
        layout()
        theme()
    }

    func layoutParentView(parentView: UIView) {
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
    }

    private func layout() {
        stackFailureEmoji.axis = .vertical
        addSubview(stackFailureEmoji)

        [self, failureEmoji, failureEmojiText, stackFailureEmoji].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            stackFailureEmoji.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackFailureEmoji.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func theme() {
        backgroundColor = .orange

        failureEmoji.textAlignment = .center
        failureEmoji.font = UIFont.systemFont(ofSize: FontFamily.extraLarge)

        failureEmojiText.font = UIFont.systemFont(ofSize: FontFamily.extraLarge)
        failureEmojiText.textAlignment = .center
        
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
