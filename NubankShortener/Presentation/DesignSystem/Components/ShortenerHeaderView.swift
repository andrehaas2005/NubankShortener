import UIKit

final class ShortenerHeaderView: UIView {
  
  let titleLabel = TitleLabel(textLabel: "Encurtar links")
  let subtitleLabel = SubTitleLabel(textLabel: "Coloque o link que você quer encurtar")
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  @available(*, unavailable)
  required init?(coder: NSCoder) { super.init(coder: coder); setup() }
  
  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(titleLabel)
    addSubview(subtitleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
