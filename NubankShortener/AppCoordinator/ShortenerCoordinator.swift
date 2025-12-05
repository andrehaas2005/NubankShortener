import UIKit

final class ShortenerCoordinator: Coordinator {
  
  let navigationController: UINavigationController
  private let container: DIContainer
  
  init(
    navigationController: UINavigationController,
    container: DIContainer
  ) {
    self.navigationController = navigationController
    self.container = container
    navigationController.navigationBar.prefersLargeTitles = true
  }
  
  func start() {
    let builder = ShortenerBuilder(container: container)
    let vc = builder.build()
    navigationController.pushViewController(vc, animated: false)
  }
}
