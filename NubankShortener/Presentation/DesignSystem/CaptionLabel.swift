import UIKit

final class CaptionLabel: UILabel {
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
    textColor = Theme.Color.primary
    font = Theme.Typography.caption
    lineBreakMode = .byCharWrapping
    translatesAutoresizingMaskIntoConstraints = false
    numberOfLines = 0
  }
}
