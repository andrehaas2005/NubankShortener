import UIKit

final class ShortenerEmptyView: UIView {
  
  private let label = BodyLabel(textLabel: "Nenhum link encurtado ainda")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { super.init(coder: coder); setup() }
  
  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: centerXAnchor),
      label.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}
