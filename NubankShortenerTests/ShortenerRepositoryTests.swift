import XCTest
@testable import NubankShortener
import Core
import Networking

final class ShortenerRepositoryTests: XCTestCase {
  
  private var sut: LinkServiceRepository!
  private let alias = AliasResponse.fixed()
  private var service: LinkServiceRepositoryMock!
  private var storage: LocalStorageProtocol!
  
  override func setUp() {
    super.setUp()
    service = LinkServiceRepositoryMock()
    storage = MockStorage()
    sut = ShortenerRepository(service: service, storage: storage)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - EMPTY STATE
  
  func test_initial_allIsEmpty() {
    XCTAssertTrue(sut.all().isEmpty)
  }
  
  // MARK: - SAVE
  
  func test_save_insertsItemAtTop() {
    sut.save(alias)
    
    let result = sut.all()
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first?.alias, "abc123")
  }
  
  func test_multiple_saves_keepLatestOnTop() {
    let alias2 = AliasResponse(
      alias: "xyz789",
      links: .init(self: "a", short: "b")
    )
    
    sut.save(alias)    // first
    sut.save(alias2)   // second
    
    let list = sut.all()
    
    // alias2 must be first
    XCTAssertEqual(list.first?.alias, "xyz789")
    // alias must be second
    XCTAssertEqual(list.last?.alias, "abc123")
  }
  
  func test_two_itens_different_alias_keepOrder() {
    let alias2 = AliasResponse(
      alias: "xyz789",
      links: .init(self: "a", short: "b")
    )
    
    sut.save(alias2)
    sut.save(alias)
    let aliasNew = AliasResponse(
      alias: "abcd1234",
      links: .init(self: "c", short: "primeiro")
    )
    
    sut.save(alias)
    
    let list = sut.all()
    XCTAssertTrue(list.first == aliasNew)
  }
  // MARK: - CLEAR
  
  func test_clear_removesAllItems() {
    sut.save(alias)
    XCTAssertEqual(sut.all().count, 1)
    
    sut.clear()
    XCTAssertTrue(sut.all().isEmpty)
  }
  
  func test_post_shorten_success() {
    service.result = .success(alias)
    sut.shorten(url: "https://github.com", completion: { _ in })
    XCTAssertEqual(service.all().count, 1)
  }
  
  func test_post_shorten_Error() {
    service.result = .failure(.invalidURL)
    sut.shorten(url: "https://github.com", completion: { _ in })
    XCTAssertEqual(service.messageError, "URL inválida.")
  } 
  func test_post_fetchOriginal_success() {
    service.result = .success(alias)
    sut.fetchOriginal(alias: alias.alias) { _ in }
    XCTAssertEqual(service.all().count, 1)
  }
  
  func test_post_fetchOriginal_Error() {
    service.result = .failure(.invalidURL)
    sut.fetchOriginal(alias: alias.alias) { _ in }
    XCTAssertEqual(service.messageError, "URL inválida.")
  }
}
