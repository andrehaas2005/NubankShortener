import Foundation
import Networking
import Core
@testable import NubankShortener

public final class NetworkClientMock: NetworkClientProtocol {
  
  public enum Mode {
    case success(Decodable)
    case failure(NetworkError)
  }
  
  // MARK: - Configuração do comportamento
  public var mode: Mode = .success(AliasResponse.fixed())
  
  // MARK: - Captura das chamadas
  private(set) var lastEndpoint: String = ""
  private(set) var lastBody: Encodable?
  
  // MARK: - POST
  public func post<T, U>(_ path: String, body: U, completion: @escaping (Result<T, Networking.NetworkError>) -> Void) where T : Decodable, U : Encodable {
    lastEndpoint = path
    lastBody = body
    
    switch mode {
    case .success(let any):
      guard let result = any as? T else {
        fatalError("Mock configurado com tipo errado. Esperado \(T.self), obtido \(type(of: any))")
      }
      completion(.success(result))
      
    case .failure(let error):
      completion(.failure(error))
    }
  }
  
  // MARK: - GET
  public func get<T: Decodable>(
    _ path: String,
    completion: @escaping (Result<T, NetworkError>) -> Void
  ) {
    lastEndpoint = path
    
    switch mode {
    case .success(let any):
      guard let result = any as? T else {
        fatalError("Mock configurado com tipo errado. Esperado \(T.self), obtido \(type(of: any))")
      }
      completion(.success(result))
      
    case .failure(let error):
      completion(.failure(error))
    }
  }
}

// Necessário para permitir sucesso padrão sem crash
private struct EmptyResponse: Decodable {}
