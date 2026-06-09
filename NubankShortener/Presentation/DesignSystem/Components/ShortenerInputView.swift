import UIKit

final class ShortenerInputView: UIView {
  
  let card = CardView()
  let textField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "https://exemplo.com"
    tf.font = Theme.Typography.body
    tf.clearButtonMode = .whileEditing
    tf.autocapitalizationType = .none
    tf.keyboardType = .URL
    tf.textColor = Theme.Color.dark
    tf.accessibilityIdentifier = "urlTextField"
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  let shortenButton: PrimaryButton = {
    let b = PrimaryButton(type: .system)
    b.setTitle("Encurtar", for: .normal)
    b.translatesAutoresizingMaskIntoConstraints = false
    return b
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { super.init(coder: coder); setup() }
  
  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    card.translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(card)
    card.addSubview(textField)
    card.addSubview(shortenButton)
    
    NSLayoutConstraint.activate([
      card.topAnchor.constraint(equalTo: topAnchor),
      card.leadingAnchor.constraint(equalTo: leadingAnchor),
      card.trailingAnchor.constraint(equalTo: trailingAnchor),
      card.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      textField.topAnchor.constraint(equalTo: card.topAnchor, constant: Theme.Spacing.sm),
      textField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: Theme.Spacing.sm),
      textField.trailingAnchor.constraint(equalTo: shortenButton.leadingAnchor, constant: -Theme.Spacing.sm),
      textField.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -Theme.Spacing.sm),
      
      shortenButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
      shortenButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -Theme.Spacing.sm),
      shortenButton.widthAnchor.constraint(equalToConstant: 96),
      shortenButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
