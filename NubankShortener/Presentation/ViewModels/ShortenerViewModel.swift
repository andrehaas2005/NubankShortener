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
  private let analytics: AnalyticsProviderProtocol
  var screenState: Core.Bindable<ShortenerStates?> = .init(.idle)
  
  // MARK: - Init
  init(
    repository: LinkServiceRepository,
    adapter: ShortenerViewDataMapperDelegate,
    analytics: AnalyticsProviderProtocol
  ) {
    self.repository = repository
    self.adapter = adapter
    self.analytics = analytics
    
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
    analytics.track(.actionButton(.actionButtonTapped))
    // validation
    guard Validators.isValidURL(urlString) else {
      screenState.value = .error("URL inválida. Verifique o formato.")
      analytics.track(.invalidURL)
      return
    }
    
    screenState.value = .loading(true)
    repository.shorten(url: urlString) { [weak self] result in
      guard let self else { return }
      DispatchQueue.main.async {
        self.screenState.value = .loading(false)
        switch result {
        case .success(let alias):
          self.analytics.track(.shortenSuccess(alias: alias.alias))
          self.handlerSuccess(alias)
        case .failure(let error):
          self.analytics.track(.shortenFailed(reason: error.descript()))
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
