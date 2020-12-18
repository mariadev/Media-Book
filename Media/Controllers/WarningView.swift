import UIKit

final class WarningView: UIView {
    
    private let failureEmoji =  UILabel()
    
    private let failureEmojiText: UILabel = {
        let label = UILabel()
        label.text = "Conexion Fail"
        label.textAlignment = .center
        return label
    }()
    
    private var stackFailureEmoji =  UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        setup()
        layout()
        applyTheme()
    }
    
    private func setup() {
        stackFailureEmoji = UIStackView(arrangedSubviews: [failureEmoji, failureEmojiText])
        addSubview(stackFailureEmoji)
        
        failureEmoji.text = "😞"
        stackFailureEmoji.axis = .vertical
        failureEmoji.textAlignment = .center
    }
    
    private func layout() {
        translatesAutoresizingMaskIntoConstraints = false
        failureEmoji.translatesAutoresizingMaskIntoConstraints = false
        stackFailureEmoji.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackFailureEmoji.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackFailureEmoji.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func applyTheme() {
        backgroundColor = .white
        failureEmoji.font = UIFont.systemFont(ofSize: 30)
        failureEmojiText.font = UIFont.systemFont(ofSize: 30)
        stackFailureEmoji.backgroundColor = .white
    }
    
    func update(state: MediaItemViewControllerState) {
        switch state {
        case.loading: ()
        case .noResults:
            stackFailureEmoji.isHidden = false
            failureEmojiText.text = "no Results"
        case.failure:
            stackFailureEmoji.isHidden = false
            failureEmojiText.text = "Conexion Error"
            failureEmoji.text = "❌"
        case.ready: ()
        }
    }
}
