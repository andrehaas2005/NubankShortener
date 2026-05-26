import UIKit

final class SecondaryButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    accessibilityHint = "Toque para Copiar"
    accessibilityTraits = .button
    accessibilityIdentifier = "SecondaryButton"
    isAccessibilityElement = true
    setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
    tintColor = Theme.Color.primary
    translatesAutoresizingMaskIntoConstraints = false
    
  }
}
