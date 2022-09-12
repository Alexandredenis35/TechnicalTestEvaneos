import UIKit

// MARK: - SectionHeaderView
final class SectionHeaderView: UICollectionReusableView {
    // MARK: IBOutlets

    @IBOutlet private var titleLabel: UILabel!

    // MARK: Public methods

    func setup(titleLabel: String) {
        self.titleLabel.text = titleLabel
    }
}
