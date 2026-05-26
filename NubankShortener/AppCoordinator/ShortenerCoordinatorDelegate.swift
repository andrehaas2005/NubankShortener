import Foundation
import Core
import UIKit

protocol ShortenerCoordinatorDelegate: Coordinator {
  func openShortURL(_ alias: AliasResponse)
  func showToast(in controller: UIViewController)
  func showError(message: String)
}
