import UIKit
import Core

/// Builder responsável por montar o módulo completo da Feature Shortener.
/// Ele garante que todas as dependências estão corretas e conectadas.
final class ShortenerBuilder: ModuleBuilderProtocol {
  
  private let container: DIContainer
  private let delegate: ShortenerCoordinatorDelegate
  init(container: DIContainer,
       delegate: ShortenerCoordinatorDelegate) {
    self.container = container
    self.delegate = delegate
  }
  
  
  func build() -> ShortenerViewController {
    let repository = container.makeRepository()
    let adapter = ShortenerViewDataMapper()
    
    let viewModel = ShortenerViewModel(
      repository: repository,
      adapter: adapter
    )
    
    let viewController = ShortenerViewController(viewModel: viewModel, delegate: delegate)
    return viewController
  }
}
