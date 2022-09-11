import UIKit

// MARK: - LastSearchedDestinationProtocol
protocol LastSearchedDestinationProtocol: AnyObject {
    func didSelectRecentDestination(id: String)
}

// MARK: - LastSearchedDestinationView
final class LastSearchedDestinationView: UIView, NibInstantiation {
    // MARK: IBOulets
    @IBOutlet private var lastDestinationButton: UIButton!

    // MARK: Properties

    private weak var recentDestinationDelegate: LastSearchedDestinationProtocol?
    private var destinationID: String?

    // MARK: - Initialisation

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

    // MARK: Private functions

    private func setupUI() {
        lastDestinationButton.backgroundColor = .clear
        lastDestinationButton.layer.cornerRadius = 20
        lastDestinationButton.layer.borderWidth = 2
        lastDestinationButton.layer.borderColor = UIColor.black.cgColor
    }

    // MARK: Public functions

    func setup(
        delegate: LastSearchedDestinationProtocol?,
        details: DestinationDetails
    ) {
        recentDestinationDelegate = delegate
        lastDestinationButton.setTitle(details.name, for: .normal)
        destinationID = details.id
    }

    // MARK: IBActions

    @IBAction private func didTapDestination() {
        recentDestinationDelegate?.didSelectRecentDestination(id: destinationID ?? "")
    }
}
