import UIKit
import Core

final class ShortenerViewController: UIViewController {
  
  // MARK: - Dependencies
  private let viewModel: ShortenerViewModel
  private let delegate: ShortenerCoordinatorDelegate
  // MARK: - UI Components
  private let headerView = ShortenerHeaderView()
  private let inputViewComponent = ShortenerInputView()
  private let listView = ShortenerListView()
  private let emptyStateView = ShortenerEmptyView()
  private var links: [AliasResponse] = []
  
  
  // MARK: - Init
  init(
    viewModel: ShortenerViewModel,
    delegate: ShortenerCoordinatorDelegate
  ) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
    title = "Take Home Test"
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    setupBindings()
    setupActions()
    configureTableView()
    view.backgroundColor = Theme.Color.background
  }
  
  // MARK: - Layout
  private func setupLayout() {
    view.addSubview(headerView)
    view.addSubview(inputViewComponent)
    view.addSubview(listView)
    view.addSubview(emptyStateView)
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.md),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),
      
      inputViewComponent.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Theme.Spacing.md),
      inputViewComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
      inputViewComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),
      
      listView.topAnchor.constraint(equalTo: inputViewComponent.bottomAnchor, constant: Theme.Spacing.lg),
      listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      listView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

    ])
  }
  
  // MARK: - Bindings
  private func setupBindings() {
    viewModel.screenState.bind { [weak self] state in
      guard let self else { return }
      switch state {
      case .idle:
        break
      case .success(let list):
        DispatchQueue.main.async {
          self.links = list
          self.listView.tableView.reloadData()
          self.emptyStateView.isHidden = !list.isEmpty
        }
      case .error(let error):
        self.delegate.showError(message: error)
        break
      case .loading(let show):
        self.inputViewComponent.shortenButton.setEnabled(!show)
        self.inputViewComponent.shortenButton.setTitle(show ? "Encurtando..." : "Encurtar", for: .normal)
      case .none:
        break
      }
    }
  }
  
  // MARK: - Actions
  private func setupActions() {
    inputViewComponent.shortenButton.addTarget(self, action: #selector(didTapShorten), for: .touchUpInside)
  }
  
  @objc private func didTapShorten() {
    view.endEditing(true)
    viewModel.shorten(inputViewComponent.textField.text ?? "")
  }
  
  // MARK: - Table
  private func configureTableView() {
    listView.tableView.dataSource = self
    listView.tableView.delegate = self
  }
}
//
//// MARK: - UITableViewDataSource
extension ShortenerViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    links.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let link = links[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShortenerListCell else {return UITableViewCell()}
    cell.configure(with: link)
    cell.action = { [weak self] in
        guard let self else { return }
        delegate.showToast(in: self)
    }
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ShortenerViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    92
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = links[indexPath.row]
    delegate.openShortURL(item)
  }
}
