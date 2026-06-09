import Core
import Networking
@testable import NubankShortener

final class LinkServiceRepositoryMock: LinkServiceRepository {

  var client: any Networking.NetworkClientProtocol = NetworkClientMock()
  var result: Result<AliasResponse, NetworkError> = .failure(NetworkError.unknown)
  private(set) var lastURL: String?
  var listAll = [AliasResponse]()
  var messageError: String = String()
  
  func save(_ alias: AliasResponse) {
    listAll.append(alias)
  }
  
  func all() -> [AliasResponse] {
    listAll
  }
  
  func shorten(url: String, completion: @escaping (Result<AliasResponse, Networking.NetworkError>) -> Void) {
    
    client.post(url, body: Body(url: url)) { (response: Result<AliasResponse, Networking.NetworkError>) in
      switch self.result {
      case .success(let success):
        self.save(success)
      case .failure(let failure):
        self.messageError = failure.descript()
      }
    }
  }
  
  func fetchOriginal(alias: String, completion: @escaping (Result<UrlResponse, Networking.NetworkError>) -> Void) {
    client.get(alias) { (response: Result<AliasResponse, Networking.NetworkError>)  in
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
