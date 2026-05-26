import XCTest
@testable import NubankShortener

final class ShortenerInputViewSnapshotTests: XCTestCase {

    func test_input_default() {
        let view = ShortenerInputView(frame: .init(x: 0, y: 0, width: 375, height: 90))
      SnapshotConfig.assertSnapshot(view: view)
    }

    func test_input_loading() {
        let view = ShortenerInputView(frame: .init(x: 0, y: 0, width: 375, height: 90))
      SnapshotConfig.assertSnapshot(view: view)
    }
}
