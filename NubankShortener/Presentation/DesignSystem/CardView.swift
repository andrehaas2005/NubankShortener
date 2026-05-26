import UIKit

final class CardView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    isAccessibilityElement = true
    accessibilityIdentifier = "CardView"
    backgroundColor = Theme.Color.surface
    layer.cornerRadius = Theme.Radius.card
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.04
    layer.shadowOffset = CGSize(width: 0, height: 6)
    layer.shadowRadius = Theme.Radius.small
  }
}
