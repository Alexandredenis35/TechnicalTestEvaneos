import Foundation
import UIKit

private var loaderContainer: UIView?

extension UIViewController {
    func showLoader() {
        loaderContainer = UIView(frame: view.bounds)
        loaderContainer?.backgroundColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let loaderView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loaderView.center = loaderContainer?.center ?? view.center
        loaderView.startAnimating()
        loaderContainer?.addSubview(loaderView)
        view.addSubview(loaderContainer ?? UIView())
    }

    func removeLoader() {
        loaderContainer?.removeFromSuperview()
        loaderContainer = nil
    }
}
