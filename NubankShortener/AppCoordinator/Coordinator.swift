import UIKit

protocol Coordinator: AnyObject {
    var router: Router { get }
    func start()
}


