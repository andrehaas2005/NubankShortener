import UIKit
import Core
import Networking


final class DIContainer {
  
  private let baseURL = URL(string: "https://url-shortener-server.onrender.com")!
  
  // MARK: - Networking
  func makeNetworkClient() -> NetworkClientProtocol {
    NetworkClient(baseURL: baseURL)
  }
  
  // MARK: - Services
  func makeLinkService() -> LinkServiceProtocol {
    LinkService(client: makeNetworkClient())
  }
  
  
  // MARK: - Repository
  func makeRepository() -> LinkRepository {
    InMemoryLinkRepository()
  }
  
  
  // MARK: - Feature
  func makeShortenerModule() -> UIViewController {
    let viewModel = ShortenerViewModel(
      service: makeLinkService(),
      repository: makeRepository()
    )
    return ShortenerViewController(viewModel: viewModel)
  }
}
