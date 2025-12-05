import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private let container: DIContainer
    private var childCoordinator: Coordinator?

    init(window: UIWindow, container: DIContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        let coordinator = ShortenerCoordinator(
            navigationController: UINavigationController(),
            container: container
        )

        childCoordinator = coordinator
        coordinator.start()

        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()
    }
}
