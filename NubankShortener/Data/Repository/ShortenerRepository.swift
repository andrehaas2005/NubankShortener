import Foundation
import Core
import Networking

public typealias LinkServiceRepository = LinkServiceProtocol&LinkRepositoryProtocol

final class ShortenerRepository: LinkServiceRepository {

  
  
  private var storage: LocalStorageProtocol
  private let service: LinkServiceProtocol
  private let pendingQueue: PendingQueueManagerProtocol
  
  init(service: LinkServiceProtocol,
       storage: LocalStorageProtocol,
       pendingQueue: PendingQueueManagerProtocol) {
    self.service = service
    self.storage = storage
    self.pendingQueue = pendingQueue
    setupQueueProcessing()
  }
  
  func save(_ alias: AliasResponse) {
    var array: [AliasResponse] = storage.fetch()
    array.insert(alias, at: 0)
    storage.save(array)
  }
  
  private func setupQueueProcessing() {
    (pendingQueue as? PedingQueueManager)?.onConnectionRestored = { [weak self] in
      self?.processPendingQueue()
    }
  }
  
  private func processPendingQueue() {
    pendingQueue.processsQueue { [weak self] url in
      self?.shorten(url: url, completion: { _ in })
    }
  }
  
  func all() -> [AliasResponse] {
    storage.fetch()
  }
  
  func clear() {
    storage.removeAll()
  }
  func all(page: Int, pageSize: Int) -> [AliasResponse] {
    storage.fetch(page: page, pageSize: pageSize)
  }
  
  func shorten(url: String, completion: @escaping (Result<AliasResponse, Networking.NetworkError>) -> Void) {
    service.shorten(url: url) { [weak self] result in
      switch result {
        
      case .success(let alias):
        self?.save(alias)
        completion(.success(alias))
      case .failure:
        self?.pendingQueue.enqueue(url)
        completion(.failure(.requestFailed(URLError(.notConnectedToInternet))))
      }
    }
  }
  
  func fetchOriginal(alias: String, completion: @escaping (Result<UrlResponse, NetworkError>) -> Void) {
    service.fetchOriginal(alias: alias) {
      completion($0)
    }
  }
}

