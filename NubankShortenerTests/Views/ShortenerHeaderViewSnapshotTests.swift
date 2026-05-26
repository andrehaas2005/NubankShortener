import XCTest
@testable import NubankShortener

final class ShortenerHeaderViewSnapshotTests: XCTestCase {
  

    func test_header_default() throws {
      try skipIfRunningOnCI()
        let view = ShortenerHeaderView(frame: .init(x: 0, y: 0, width: 375, height: 120))
      SnapshotConfig.assertSnapshot(view: view)
    }

    func test_header_customized() throws {
      try skipIfRunningOnCI()
        let view = ShortenerHeaderView(frame: .init(x: 0, y: 0, width: 375, height: 120))
        SnapshotConfig.assertSnapshot(view: view)
    }
}
