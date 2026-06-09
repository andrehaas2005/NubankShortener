import UIKit

final class ShortenerListView: UIView {
  
  let tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .insetGrouped)
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.backgroundColor = .clear
    tv.register(ShortenerListCell.self, forCellReuseIdentifier: "cell")
    return tv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { super.init(coder: coder); setup() }
  
  private func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
