import UIKit

// MARK: - DestinationCollectionViewCell
final class DestinationCollectionViewCell: UICollectionViewCell {
    // MARK: IBOulets

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var destinationLabel: UILabel!
    @IBOutlet private var labelTagButton: UIButton!
    @IBOutlet private var containerImageView: UIImageView!
    @IBOutlet private var stackViewRating: UIStackView!

    // MARK: Properties

    private lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.layer.masksToBounds = true
        gradientView.startColor = .black.withAlphaComponent(0)
        gradientView.endColor = .black.withAlphaComponent(0.5)
        return gradientView
    }()

    // MARK: View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUILabelTag()
        setupContainerViewShadow()
        setupContainerImageViewRadius()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = containerImageView.frame
        containerImageView.addSubview(gradientView)
    }

    // MARK: Private functions

    private func setupUILabelTag() {
        labelTagButton.titleLabel?.font = UIFont.avertaBold(fontSize: 16)
        labelTagButton.backgroundColor = UIColor.evaneos(color: .ink)
        labelTagButton.cornerRadius(with: 5)
    }

    private func setupContainerViewShadow() {
        containerView.addShadow(opacity: 0.25, radius: 4.0, offset: CGSize(width: 0, height: 4.0))
    }

    private func setupContainerImageViewRadius() {
        containerImageView.cornerRadius(with: 16)
    }

    private func configureStackView(rating: Int) {
        stackViewRating.subviews.enumerated().forEach { index, starImage in
            guard let starImageView = starImage as? UIImageView else {
                return
            }
            starImageView.tintColor = UIColor.evaneos(color: .gold)
            starImageView.image = UIImage(systemName: index < rating ? "star.fill" : "star")
        }
    }

    private func downloadImage(url: URL) {
        // TODO: Move this logic in ViewModel or Parent ViewModel
        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.containerImageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }

    // MARK: Public functions

    func setupCell(destination: Destination) {
        destinationLabel.text = destination.name
        configureStackView(rating: destination.rating)
        labelTagButton.setTitle(destination.tag, for: .normal)
        downloadImage(url: destination.picture)
    }
}
