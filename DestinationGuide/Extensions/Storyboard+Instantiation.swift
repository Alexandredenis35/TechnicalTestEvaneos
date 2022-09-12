import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        let sceneStoryboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        let viewController = sceneStoryboard.instantiateInitialViewController()
        guard let typedViewController = viewController as? Self else {
            fatalError("The initialViewController of '\(sceneStoryboard)' is not of class '\(self)'")
        }
        return typedViewController
    }
}
