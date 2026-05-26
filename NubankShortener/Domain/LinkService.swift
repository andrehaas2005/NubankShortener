import Foundation
import Core
import Networking

public protocol LinkServiceProtocol {
  func shorten(url: String, completion: @escaping (Result<AliasResponse, NetworkError>) -> Void)
  func fetchOriginal(alias: String, completion: @escaping (Result<UrlResponse, NetworkError>) -> Void)
}


final class LinkService: LinkServiceProtocol {
  private let client: NetworkClientProtocol
  
  init(client: NetworkClientProtocol) {
    self.client = client
  }
  
  func shorten(url: String, completion: @escaping (Result<Core.AliasResponse, NetworkError>) -> Void) {
    client.post("/api/alias", body: Body(url: url)) { completion($0) }
  }
  
  func fetchOriginal(alias: String, completion: @escaping (Result<Core.UrlResponse, Networking.NetworkError>) -> Void) {
    client.get("/api/alias/\(alias)") { completion($0) }
  }
}
