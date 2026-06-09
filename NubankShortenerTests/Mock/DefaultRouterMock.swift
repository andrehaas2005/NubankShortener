import UIKit
import Core
@testable import NubankShortener

final class DefaultRouterMock: Router {
  
  let navigationController: UINavigationController = UINavigationController()
  private(set) var alias: AliasResponse?
  private(set) var controller: UIViewController?
  private(set) var message: String?
  private(set) var openShortURLCall = 0
  private(set) var pushControll = 0
  private(set) var presentControll = 0
  private(set) var showToastCall = 0
  
  
  func openShortURL(_ alias: AliasResponse) {
    openShortURLCall += 1
    self.alias = alias
  }
  
  func showToast(viewController: UIViewController, _ message: String) {
    showToastCall += 1
    self.controller = viewController
  }
  
  func push(_ viewController: UIViewController, animated: Bool) {
    pushControll += 1
    self.controller = viewController
  }
  
  func present(_ viewController: UIViewController, animated: Bool) {
    presentControll += 1
    self.controller = viewController
  }
  
  func pop(animated: Bool) {
    
  }
  
  func setRoot(_ viewController: UIViewController, animated: Bool) {
    self.controller = viewController
  }
}
