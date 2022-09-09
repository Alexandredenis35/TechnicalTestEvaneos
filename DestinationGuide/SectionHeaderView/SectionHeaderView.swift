import UIKit

class SectionHeaderView: UICollectionReusableView {
    @IBOutlet private var titleLabel: UILabel!

    func setup(titleLabel: String) {
        self.titleLabel.text = titleLabel
    }
}
