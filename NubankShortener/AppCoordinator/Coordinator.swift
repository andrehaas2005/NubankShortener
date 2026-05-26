import UIKit

/// Base para todos os coordinators do app.
/// Cada fluxo possui um coordinator próprio.
protocol Coordinator: AnyObject {
    var router: Router { get }
    func start()
}


