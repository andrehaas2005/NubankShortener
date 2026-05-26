import Foundation
import Core
import Networking

public typealias LinkServiceRepository = LinkServiceProtocol&LinkRepositoryProtocol

final class ShortenerRepository: LinkServiceRepository {
  
  private var storage: [AliasResponse] = []
  private let service: LinkServiceProtocol
  
  init(service: LinkServiceProtocol) {
    self.service = service
  }
  
  func save(_ alias: AliasResponse) {
    storage.insert(alias, at: 0)
  }
  
  
  func all() -> [AliasResponse] {
    storage
  }
  
  func clear() {
    storage.removeAll()
  }
  
  func shorten(url: String, completion: @escaping (Result<Core.AliasResponse, Networking.NetworkError>) -> Void) {
    service.shorten(url: url) {
      completion($0)
    }
  }
  
  func fetchOriginal(alias: String, completion: @escaping (Result<UrlResponse, NetworkError>) -> Void) {
    service.fetchOriginal(alias: alias) {
      completion($0)
    }
  }
}

