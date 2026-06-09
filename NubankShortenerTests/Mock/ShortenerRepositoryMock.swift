import Foundation
import Core
import Networking
@testable import NubankShortener

final class ShortenerRepositoryMock: LinkServiceRepository {
  public var client = NetworkClientMock()
  
  
  var initial: [AliasResponse] = []
  var saved: [AliasResponse] = []
  var success: Bool = false
  var failure: Bool = false
  var failureMessage: String = ""
  func save(_ alias: AliasResponse) {
    saved.append(alias)
  }
  
  func all() -> [AliasResponse] {
    initial + saved
  }
  
  func clear() {
    initial.removeAll()
    saved.removeAll()
  }
  
  func shorten(url: String, completion: @escaping (Result<AliasResponse, Networking.NetworkError>) -> Void) {
    let body = Body(url: url)
    client.post("https://full.com", body: body) { (result: Result<AliasResponse, NetworkError>) in
      switch result {
      case .success(let data):
        self.save(data)
        self.success = true
        completion(.success(data))
      case .failure(let error):
        self.failure = true
        self.failureMessage = error.descript()
        completion(.failure(error))
      }
    }
  }
  
  func fetchOriginal(alias: String, completion: @escaping (Result<UrlResponse, Networking.NetworkError>) -> Void) {
    
  }
}
