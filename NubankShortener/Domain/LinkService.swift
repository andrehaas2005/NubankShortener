import Foundation
import Core
import Networking

public protocol LinkServiceProtocol {
  func shorten(url: String) async throws -> AliasResponse
  func fetchOriginal(alias: String) async throws -> UrlResponse
}


final class LinkService: LinkServiceProtocol {
  private let client: NetworkClientProtocol
  
  init(client: NetworkClientProtocol) {
    self.client = client
  }
  
  
  func shorten(url: String) async throws -> AliasResponse {
    struct Body: Encodable { let url: String }
    return try await client.post("/api/alias", body: Body(url: url))
  }
  
  
  func fetchOriginal(alias: String) async throws -> UrlResponse {
    return try await client.get("/api/alias/\(alias)")
  }
}
