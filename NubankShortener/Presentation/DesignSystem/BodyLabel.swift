import UIKit

final class BodyLabel: UILabel {
  private var textLabel: String?
  
  init(textLabel: String? = nil) {
    self.textLabel = textLabel
    super.init(frame: .zero)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    text = textLabel
    textColor = Theme.Color.dark
    font = Theme.Typography.body
    accessibilityIdentifier = "BodyLabel"
    accessibilityLabel = textLabel
    accessibilityTraits = .staticText
    translatesAutoresizingMaskIntoConstraints = false
    numberOfLines = 0
  }
}
