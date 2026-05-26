import Core
import Networking
@testable import NubankShortener

final class LinkServiceRepositoryMock: LinkServiceRepository {

  var client: any Networking.NetworkClientProtocol = NetworkClientMock()
  var result: Result<AliasResponse, NetworkError> = .failure(NetworkError.unknown)
  private(set) var lastURL: String?
  var listAll = [Core.AliasResponse]()
  var messageError: String = String()
  
  func save(_ alias: Core.AliasResponse) {
    listAll.append(alias)
  }
  
  func all() -> [Core.AliasResponse] {
    listAll
  }
  
  func shorten(url: String, completion: @escaping (Result<Core.AliasResponse, Networking.NetworkError>) -> Void) {
    
    client.post(url, body: Body(url: url)) { (response: Result<Core.AliasResponse, Networking.NetworkError>) in
      switch self.result {
      case .success(let success):
        self.save(success)
      case .failure(let failure):
        self.messageError = failure.descript()
      }
    }
  }
  
  func fetchOriginal(alias: String, completion: @escaping (Result<Core.UrlResponse, Networking.NetworkError>) -> Void) {
    client.get(alias) { (response: Result<Core.AliasResponse, Networking.NetworkError>)  in
      switch self.result {
      case .success(let success):
        self.save(success)
      case .failure(let failure):
        self.messageError = failure.descript()
      }
    }
  }
  
  func clear() {
    listAll.removeAll()
  }
}
