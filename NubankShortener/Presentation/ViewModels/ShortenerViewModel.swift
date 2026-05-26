import Combine
import Core
import Foundation
import Networking



public protocol ShortenerViewModelProtocol: AnyObject {
  var screenState: Bindable<ShortenerStates?> { get }
}

final class ShortenerViewModel: ShortenerViewModelProtocol {
  
  // MARK: - Dependencies
  private let repository: LinkServiceRepository
  private let adapter: ShortenerViewDataMapperDelegate
  var screenState: Core.Bindable<ShortenerStates?> = .init(.idle)
  
  // MARK: - Init
  init(
    repository: LinkServiceRepository,
    adapter: ShortenerViewDataMapperDelegate
  ) {
    self.repository = repository
    self.adapter = adapter
    
    // initial load from repository
    screenState.value = .success(repository.all())
  }
  
  // MARK: - Public actions
  
  /// Encurta a URL informada.
  /// Valida, persiste e atualiza estado.
  func shorten(_ urlString: String) {
    
    // validation
    guard Validators.isValidURL(urlString) else {
      screenState.value = .error("URL inválida. Verifique o formato.")
      return
    }
    
    screenState.value = .loading(true)
    repository.shorten(url: urlString) { [weak self] result in
      guard let self else { return }
      DispatchQueue.main.async {
        self.screenState.value = .loading(false)
        switch result {
        case .success(let alias):
          self.handlerSuccess(alias)
        case .failure(let error):
          self.screenState.value = .error(error.descript())
        }
      }
    }
  }
  
  private func handlerSuccess(_ alias: AliasResponse) {
    self.repository.save(alias)
    self.screenState.value = .success(self.repository.all())
  }
  
  /// Atualiza a lista com os dados do repositório.
  func refresh() {
    self.screenState.value = .success(self.repository.all())
  }
}
