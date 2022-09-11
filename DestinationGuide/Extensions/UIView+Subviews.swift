import UIKit
extension UIView {
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func cornerRadius(with cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }

    func addShadow(opacity: Float, radius: CGFloat, offset: CGSize) {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
