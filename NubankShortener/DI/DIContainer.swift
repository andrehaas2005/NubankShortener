import UIKit
import Core
import Networking

final class DIContainer {
    
    private let baseURL = URL(string: "https://url-shortener-server.onrender.com")!

    // MARK: - Networking Layer
    func makeNetworkClient() -> NetworkClientProtocol {
        NetworkClient(baseURL: baseURL)
    }

    // MARK: - Repository
    func makeRepository() -> LinkServiceRepository {
      let service = LinkService(client: makeNetworkClient())
      return ShortenerRepository(service: service)
    }
}
