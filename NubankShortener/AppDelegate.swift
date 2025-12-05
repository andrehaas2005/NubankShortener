import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var appCoordinator: AppCoordinator?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    
    let container = DIContainer()
    let coordinator = AppCoordinator(window: window, container: container)
    self.appCoordinator = coordinator
    
    coordinator.start()
    
    return true
  }
}
