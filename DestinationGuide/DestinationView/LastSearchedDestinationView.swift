import UIKit

protocol LastSearchedDestinationProtocol: AnyObject {
    func didSelectRecentDestination(id: String)
}

class LastSearchedDestinationView: UIView, NibInstantiation {
    @IBOutlet private var lastDestinationButton: UIButton!

    private weak var recentDestinationDelegate: LastSearchedDestinationProtocol?
    private var destinationID: String?

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
        recentDestinationDelegate?.didSelectRecentDestination(id: destinationID ?? "")
    }

    private func setupUI() {
        lastDestinationButton.backgroundColor = .clear
        lastDestinationButton.layer.cornerRadius = 20
        lastDestinationButton.layer.borderWidth = 2
        lastDestinationButton.layer.borderColor = UIColor.black.cgColor
    }

    func setup(
        delegate: LastSearchedDestinationProtocol?,
        details: DestinationDetails
    ) {
        recentDestinationDelegate = delegate
        lastDestinationButton.setTitle(details.name, for: .normal)
        destinationID = details.id
    }
}
