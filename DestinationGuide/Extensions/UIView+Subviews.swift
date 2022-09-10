import Foundation
import UIKit
extension UIView {
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
