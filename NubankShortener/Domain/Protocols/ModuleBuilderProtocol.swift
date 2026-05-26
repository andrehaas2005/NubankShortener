import UIKit

protocol ModuleBuilderProtocol {
    associatedtype ViewControllerType: UIViewController
    func build() -> ViewControllerType
}
