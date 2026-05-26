import UIKit

final class AppCoordinator: Coordinator {

    let router: Router
    private let container: DIContainer
    private var childCoordinator: Coordinator?

    init(window: UIWindow, container: DIContainer) {
        let navigation = UINavigationController()
        navigation.navigationBar.prefersLargeTitles = true

        self.router = DefaultRouter(navigationController: navigation)
        self.container = container

        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    func start() {
        let shortenerCoordinator = ShortenerCoordinator(router: router, container: container)
        childCoordinator = shortenerCoordinator
        shortenerCoordinator.start()
    }
}
