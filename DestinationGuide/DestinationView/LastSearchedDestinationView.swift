import UIKit

protocol LastSearchedDestinationProtocol: AnyObject {
    func didSelectRecentDestination(id: String)
}

class LastSearchedDestinationView: UIView, NibInstantiation {
    @IBOutlet private var destinationsStackView: UIStackView!
    @IBOutlet private var lastDestinationButton: UIButton!

    private weak var recentDestinationDelegate: LastSearchedDestinationProtocol?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setupUI()
    }

    @IBAction private func didTapDestination() {
        recentDestinationDelegate?.didSelectRecentDestination(id: "")
    }

    private func setupUI() {
        lastDestinationButton.backgroundColor = .clear
        lastDestinationButton.layer.cornerRadius = 10
        lastDestinationButton.layer.borderWidth = 2
        lastDestinationButton.layer.borderColor = UIColor.black.cgColor
    }

    func setup(delegate: LastSearchedDestinationProtocol?) {
        recentDestinationDelegate = delegate
    }
}
