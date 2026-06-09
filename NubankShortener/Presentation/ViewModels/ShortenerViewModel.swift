import Combine
import Core
import Foundation
import Networking

final class ShortenerViewModel: ShortenerViewModelProtocol {
  
  // MARK: - Dependencies
  private let repository: LinkServiceRepository
  private let adapter: ShortenerViewDataMapperDelegate
  private var currentPage = 0
  private let pageSize = 6
  private var allLinks: [AliasResponse] = []
  private var hasMorePages = true
  var screenState: Core.Bindable<ShortenerStates?> = .init(.idle)
  
  // MARK: - Init
  init(
    repository: LinkServiceRepository,
    adapter: ShortenerViewDataMapperDelegate
  ) {
    self.repository = repository
    self.adapter = adapter
    
    // initial load from repository
//    screenState.value = .success(repository.all())
    loadNextPage()
  }
  
  // MARK: - Public actions
  func loadNextPage() {
    screenState.value = .loading(true)
    guard hasMorePages else {
      screenState.value = .loading(false)
      return
    }
    let newItems = repository.all(page: currentPage, pageSize: pageSize)
    
    guard !newItems.isEmpty else {
      hasMorePages = false
      screenState.value = .loading(false)
      return
    }
    allLinks.append(contentsOf: newItems)
    currentPage += 1
    screenState.value = .loading(false)
    screenState.value = .success(allLinks)
  }
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
    resetPagination()
    loadNextPage()
//    self.screenState.value = .success(self.repository.all())
  }
  
  private func resetPagination() {
    currentPage = 0
    allLinks = []
    hasMorePages = true
  }
}
