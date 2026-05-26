import Networking
import Core

public protocol LinkServiceProtocol {
  func shorten(url: String, completion: @escaping (Result<AliasResponse, NetworkError>) -> Void)
  func fetchOriginal(alias: String, completion: @escaping (Result<UrlResponse, NetworkError>) -> Void)
}


