import UIKit
import Core
import Networking

final class DIContainer {
    
    private let baseURL = URL(string: "https://url-shortener-server.onrender.com")!

    // MARK: - Networking Layer
    func makeNetworkClient() -> NetworkClientProtocol {
        NetworkClient(baseURL: baseURL)
    }
  
  func makeLocalStorage() -> LocalStorageProtocol {
    LocalStorage()
  }
  
  func makePendingStorage() -> PendingStorageProtocol {
    PendingStorage()
  }
  
  func makePendingQueueManager() -> PendingQueueManagerProtocol {
    let storage = makePendingStorage()
    return PedingQueueManager(storage: storage)
  }

    // MARK: - Repository
    func makeRepository() -> LinkServiceRepository {
      let service = LinkService(client: makeNetworkClient())
      let localStorage = makeLocalStorage()
      let pendingManager = makePendingQueueManager()
      return ShortenerRepository(service: service,
                                 storage: localStorage,
                                 pendingQueue: pendingManager)
    }
}
