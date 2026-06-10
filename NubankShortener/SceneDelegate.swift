import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var appCoordinator: AppCoordinator?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let scene = scene as? UIWindowScene else { return }
    
    let window = UIWindow(windowScene: scene)
    self.window = window
    showLoadingScreen(in: window)
    let container = DIContainer()
    self.appCoordinator = AppCoordinator(window: window, container: container)
    container.makeFeatureFlagProvider().fetchRemoteConfig { [weak self] in
      DispatchQueue.main.async {
        self?.appCoordinator?.start()
      }
    }
  }
  
  private func showLoadingScreen(in window: UIWindow) {
      let loading = UIViewController()
      loading.view.backgroundColor = Theme.Color.background
      
      let indicator = UIActivityIndicatorView(style: .large)
      indicator.color = Theme.Color.principalColor
      indicator.translatesAutoresizingMaskIntoConstraints = false
      indicator.startAnimating()
      
      let label = UILabel()
      label.text = "Carregando..."
      label.font = Theme.Typography.caption
      label.textColor = Theme.Color.principalColor
      label.translatesAutoresizingMaskIntoConstraints = false
      
      loading.view.addSubview(indicator)
      loading.view.addSubview(label)
      
      NSLayoutConstraint.activate([
          indicator.centerXAnchor.constraint(equalTo: loading.view.centerXAnchor),
          indicator.centerYAnchor.constraint(equalTo: loading.view.centerYAnchor),
          
          label.centerXAnchor.constraint(equalTo: loading.view.centerXAnchor),
          label.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 12)
      ])
      
      window.rootViewController = loading
      window.makeKeyAndVisible()
  }
}
