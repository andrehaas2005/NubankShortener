import UIKit

final class AppCoordinator: Coordinator {
  
  let router: Router
  private let container: DIContainer
  private let featureFlags: FeatureFlagProviderProtocol
  private var childCoordinator: Coordinator?
  
  init(window: UIWindow, container: DIContainer) {
    let navigation = UINavigationController()
    navigation.navigationBar.prefersLargeTitles = true
    
    self.router = DefaultRouter(navigationController: navigation)
    self.container = container
    self.featureFlags = container.makeFeatureFlagProvider()
    
    window.rootViewController = navigation
    window.makeKeyAndVisible()
  }
  
  func start() {
    featureFlags.isEnabled(.isHistoricoEnabled) ? showWithHistorico() : showWithoutHistorico()
  }
  
  private func showWithoutHistorico() {
    //TODO: criar versão sem historico
  }
  
  private func showWithHistorico() {
    let shortenerCoordinator = ShortenerCoordinator(router: router,
                                                    container: container,
                                                    featureFlag: featureFlags)
    childCoordinator = shortenerCoordinator
    shortenerCoordinator.start()
  }
}
