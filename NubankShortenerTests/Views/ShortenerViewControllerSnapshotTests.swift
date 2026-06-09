import XCTest
import SnapshotTesting
@testable import NubankShortener
import Core
import Networking

final class ShortenerViewControllerSnapshotTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  // MARK: - Helpers
  
private func makeSUT(
    links: [AliasResponse] = [],
    isLoading: Bool = false,
    error: String? = nil
  ) -> ShortenerViewController {
    let repo   = LinkServiceRepositoryMock()
    let adapter = ShortenerViewDataMapperMock()
    
    let vm = ShortenerViewModel(
      repository: repo,
      adapter: adapter
    )
    
    return ShortenerViewController(viewModel: vm,
                                   delegate: ShortenerCoordinatorMock())
  }
  
  // MARK: - Tests
  
  func test_snapshot_emptyState() throws {
    try skipIfRunningOnCI()
    let sut = makeSUT(links: [])
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
  
   func test_snapshot_withItems() throws {
     try skipIfRunningOnCI()
    let alias = AliasResponse(
      alias: "abc123",
      links: .init(self: "https://full.com", short: "https://short.com")
    )
    let alias2 = AliasResponse(
      alias: "xyz999",
      links: .init(self: "https://apple.com", short: "https://a.co/x9")
    )
    
    let sut = makeSUT(links: [alias, alias2])
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
  
  func test_snapshot_loadingState() throws {
    try skipIfRunningOnCI()
    let sut = makeSUT(isLoading: true)
    sut.view.frame = CGRect(origin: .zero, size: SnapshotConfig.device.size ?? .zero)
    sut.view.layoutIfNeeded()
    
    SnapshotConfig.assertSnapshot(vc: sut)
  }
}

class ShortenerCoordinatorMock: ShortenerCoordinatorDelegate {
  var router: any NubankShortener.Router = DefaultRouterMock()
  
  func openShortURL(_ alias: AliasResponse) {
    
  }
  
  func showToast(in controller: UIViewController) {
    
  }
  
  func showError(message: String) {
    
  }
  
  func start() {
    
  }
}
