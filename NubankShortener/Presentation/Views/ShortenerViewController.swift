import UIKit
internal import Combine
import Core

final class ShortenerViewController: UIViewController, UITextFieldDelegate {

    private let viewModel: ShortenerViewModel
    private var cancellables = Set<AnyCancellable>()

    private let headerView = HeaderView()
    private let inputCardView = InputCardView()
    private let listView = LinksListView()

    init(viewModel: ShortenerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Encurtador"
    }

    required init?(coder: NSCoder) { fatalError("init(coder:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.background

        setupLayout()
        setupBindings()
        setupActions()

        inputCardView.textField.delegate = self
    }

    private func setupLayout() {
        view.addSubview(headerView)
        view.addSubview(inputCardView)
        view.addSubview(listView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.md),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),

            inputCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Theme.Spacing.md),
            inputCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
            inputCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),

            listView.topAnchor.constraint(equalTo: inputCardView.bottomAnchor, constant: Theme.Spacing.lg),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupActions() {
        inputCardView.actionButton.addTarget(self, action: #selector(didTapShorten), for: .touchUpInside)
    }

    @objc private func didTapShorten() {
        view.endEditing(true)
        Task { await viewModel.shorten(inputCardView.textField.text ?? "") }
    }

    private func setupBindings() {
        viewModel.$links
            .receive(on: RunLoop.main)
            .sink { [weak self] links in
                self?.listView.update(links)
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] loading in
                self?.inputCardView.actionButton.setEnabled(!loading)
                self?.inputCardView.actionButton.setTitle(loading ? "Encurtando..." : "Encurtar", for: .normal)
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] msg in
                guard let msg else { return }
                self?.presentError(msg)
            }
            .store(in: &cancellables)
    }

    private func presentError(_ msg: String) {
        let alert = UIAlertController(title: "Ops", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

