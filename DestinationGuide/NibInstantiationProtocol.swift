import UIKit

protocol NibInstantiation: AnyObject {
    static var nib: UINib { get }
}

extension NibInstantiation {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibInstantiation where Self: UIView {
    func loadNibContent() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        for case let view as UIView in type(of: self).nib.instantiate(withOwner: self, options: nil) {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            NSLayoutConstraint.activate(layoutAttributes.map { attribute in
                NSLayoutConstraint(
                    item: view, attribute: attribute,
                    relatedBy: .equal,
                    toItem: self, attribute: attribute,
                    multiplier: 1, constant: 0.0
                )
            })
        }
    }
}
