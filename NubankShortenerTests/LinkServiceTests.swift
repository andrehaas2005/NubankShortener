import XCTest
import Networking
import Core
@testable import NubankShortener

final class LinkServiceTests: XCTestCase {
  
  private var client: NetworkClientMock!
  private var sut: LinkService!
  private var result: AliasResponse!
  private var fetchOriginalResult: UrlResponse!
  override func setUp() {
    super.setUp()
    client = NetworkClientMock()
    sut = LinkService(client: client)
  }
  
  override func tearDown() {
    client = nil
    sut = nil
    super.tearDown()
  }
  
  // MARK: - shorten()
  
  func test_shorten_success() throws {
    let expected = AliasResponse.fixed()
    
    client.mode = .success(expected)
    
    
    sut.shorten(url: "https://apple.com") { result in
      
      switch result {
      case .success(let success):
        self.result = success
      case .failure:
        XCTFail("Expected error not thrown")
      }
      
    }
    
    
    XCTAssertEqual(result.alias, expected.alias)
    XCTAssertEqual(client.lastEndpoint, "/api/alias")
    
    let body = client.lastBody as? Body
    XCTAssertEqual(body?.url, "https://apple.com")
  }
  
  func test_shorten_whenRequestFails_returnsHTTPError() throws {
    client.mode = .failure(NetworkError.httpError(500))
    sut.shorten(url: "https://apple.com") { result in
      switch result {
      case .success:
        XCTFail("Expected error not thrown")
      case .failure(let error):
        guard case .httpError(let statusCode) = error else {
          XCTFail("Expected httpError")
          return
        }
        
        XCTAssertEqual(statusCode, 500)
        XCTAssertEqual(error.descript(), "Erro HTTP: 500")
      }
    }
  }
  
  // MARK: - fetchOriginalURL()
  
  func test_fetchOriginal_success() throws {
    let expected = UrlResponse(url: "https://full.com")
    client.mode = .success(expected)
    sut.fetchOriginal(alias: "abc123") { result in
      switch result {
      case .success(let success):
        self.fetchOriginalResult = success
      case .failure:
        XCTFail("Expected error not thrown")
      }
    }
    
    XCTAssertEqual(fetchOriginalResult.url, expected.url)
    XCTAssertEqual(client.lastEndpoint, "/api/alias/abc123")
  }
  
  func test_fetchOriginal_failure() {
    client.mode = .failure(NetworkError.unknown)
    sut.fetchOriginal(alias: "abc123") { result in
      switch result {
      case .success:
        XCTFail("Expected error not thrown")
      case .failure(let error):
        XCTAssertEqual(error.descript(), "Erro de rede. Tente novamente.")
      }
    }
  }
}
