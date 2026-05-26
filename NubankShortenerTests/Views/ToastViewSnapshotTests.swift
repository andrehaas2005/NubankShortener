import XCTest
import SnapshotTesting
@testable import NubankShortener
import Core
import Networking


final class ToastViewSnapshotTests: XCTestCase {

    func test_toast_view_default() throws {
      try skipIfRunningOnCI()
      let view = UIView(frame: .init(x: 0, y: 0, width: 375, height: 120))
      view.backgroundColor = Theme.Color.principalColor
        let toastView = ToastView(message: "Teste Toast - Default")
      toastView.show(in: view)
      SnapshotConfig.assertSnapshot(view: view)
      toastView.hide()
    }
}
