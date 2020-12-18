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

        stackFailureEmoji.axis = .vertical
        failureEmoji.textAlignment = .center
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
            failureEmojiText.text = "No Results"
        case .failure:
            isHidden = false
            failureEmoji.text = "😞"
            failureEmojiText.text = "Conexion Error"
            failureEmoji.text = "❌"
        case .loading:
            isHidden = false
            failureEmoji.text = "Loading..."
            failureEmojiText.text = ""
        default:
            isHidden = true
            failureEmoji.text = ""
            failureEmojiText.text = ""
        }
    }
}
