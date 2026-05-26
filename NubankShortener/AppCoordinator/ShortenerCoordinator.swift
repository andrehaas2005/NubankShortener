import UIKit
import Core

/// Coordinator responsável pelo fluxo principal da feature de encurtar links.
final class ShortenerCoordinator: ShortenerCoordinatorDelegate {
  
  let router: Router
  private let container: DIContainer
  
  init(router: Router, container: DIContainer = DIContainer()) {
    self.router = router
    self.container = container
  }
  
  func start() {
    let container = DIContainer()
    let builder = ShortenerBuilder(container: container, delegate: self)
    let vc = builder.build()
    
    router.setRoot(vc, animated: false)
  }
  
  func openShortURL(_ alias: AliasResponse) {
    guard let url = URL(string: alias.links.short) else { return }
    UIApplication.shared.open(url)
  }
  
  func showToast(in controller: UIViewController) {
    router.showToast(viewController: controller, "Link copiado!")
  }
  
  func showError(message: String) {
    let alert = UIAlertController(
      title: "Ops",
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    router.present(alert, animated: true)
  }
}

