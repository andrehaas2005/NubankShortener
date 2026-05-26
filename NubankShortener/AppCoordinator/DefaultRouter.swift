import UIKit

/// Implementação padrão da abstração Router.
/// Envolve um UINavigationController real.
final class DefaultRouter: Router {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Navigation

    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func setRoot(_ viewController: UIViewController, animated: Bool) {
        navigationController.setViewControllers([viewController], animated: animated)
    }
  
  func showToast(viewController: UIViewController, _ message: String) {
    let toast = ToastView(message: message)
    guard let view = viewController.view else { return }
    toast.show(in: view)
  }
}
