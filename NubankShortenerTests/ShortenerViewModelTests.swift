import XCTest
import Core
import Networking
@testable import NubankShortener

final class ShortenerViewModelTests: XCTestCase {
  
  // Mocks
  
  private var repo: ShortenerRepositoryMock!
  private var adapter: ShortenerViewDataMapperMock!
  private var sut: ShortenerViewModel!
  private let alias = AliasResponse.fixed()
  private let uiModel = ShortenerUIModel.fixed()
  // MARK: - Setup
  
  override func setUp() {
    super.setUp()
    
    repo    = ShortenerRepositoryMock()
    adapter = ShortenerViewDataMapperMock()

    // initial mock state
    repo.initial = [alias]
    adapter.ui   = [uiModel]
    
    sut = ShortenerViewModel(
      repository: repo,
      adapter: adapter
    )
  }
  
  override func tearDown() {
    repo = nil
    adapter = nil
    sut = nil
    super.tearDown()
  }
  
  
  // MARK: - INVALID URL
  
  func test_shorten_invalidURL_setsError() {
    sut.shorten("invalid-url")
    XCTAssertEqual(sut.screenState.value, .error("URL inválida. Verifique o formato."))
  }
  
  
  // MARK: - SUCCESS
  
  func test_shorten_success_savesToRepo_andUpdatesUI() {
 
    repo.client.mode = .success(alias)
    sut.shorten("https://ok.com")
    
    XCTAssertEqual(self.repo.saved.count, 1)
    XCTAssertFalse(self.repo.failure)
    XCTAssertTrue(self.repo.success)
  }
  // MARK: - ERROR HANDLING
  
  func test_error_decodingFailed()  {

    repo.client.mode = .failure(NetworkError.decodingFailed(NSError()))
    sut.shorten("https://ok.com")
    XCTAssertFalse(self.repo.success)
    XCTAssertTrue(self.repo.failure)
    XCTAssertEqual(self.repo.failureMessage, "Erro ao ler resposta do servidor.")
  }
  
  func test_error_httpError500() {
 
    repo.client.mode = .failure(NetworkError.httpError(500))
    
    sut.shorten("https://ok.com")
    XCTAssertFalse(self.repo.success)
    XCTAssertTrue(self.repo.failure)
    XCTAssertEqual(self.repo.failureMessage, "Erro HTTP: 500")
  }
  
  func test_error_invalidURL() {

    repo.client.mode = .failure(NetworkError.invalidURL)
    
    sut.shorten("https://ok.com")
    XCTAssertFalse(self.repo.success)
    XCTAssertTrue(self.repo.failure)
    XCTAssertEqual(self.repo.failureMessage, "URL inválida.")
  }
  
  func test_error_networkUnknown() {
    repo.client.mode = .failure(NetworkError.unknown)
    sut.shorten("https://ok.com")
    XCTAssertFalse(self.repo.success)
    XCTAssertTrue(self.repo.failure)
    XCTAssertEqual(self.repo.failureMessage, "Erro de rede. Tente novamente.")
  }
}
  
  
extension ShortenerUIModel {
  static func fixed() ->ShortenerUIModel {
    ShortenerUIModel(id: UUID(),
                     alias: "abc123",
                     short: "https://short.com",
                     original: "https://full.com",
                     displayTitle: "display Title",
                     displaySubtitle: "display Subtitle")
  }
}

extension AliasResponse {
  static func fixed() -> AliasResponse {
    return .init(
      alias: "abc123",
      links: .init(
        self: "https://full.com",
        short: "https://short.com"
      )
    )
  }
}
