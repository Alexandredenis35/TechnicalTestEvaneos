import UIKit

class DestinationsViewController: UIViewController {
    @IBOutlet private var destinationsCollectionView: UICollectionView!

    weak var coordinator: AppCoordinator?
    var viewModel: DestinationsViewModel?

    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 32, right: 0)
        layout.minimumLineSpacing = 32
        layout.itemSize = .init(width: 342, height: 280)
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        DestinationFetchingService().getDestinations { destinations in
            self.viewModel?.destinations = Array(try! destinations.get()).sorted(by: { $0.name < $1.name })

            DispatchQueue.main.async {
                self.destinationsCollectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        destinationsCollectionView.collectionViewLayout = collectionViewLayout
        destinationsCollectionView.dataSource = self
        destinationsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        destinationsCollectionView.delegate = self
        destinationsCollectionView.register(
            UINib(nibName: "DestinationCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MyCell"
        )
        destinationsCollectionView.register(
            UINib(nibName: "SectionHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView"
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout extension
extension DestinationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        )

        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required, // Width is fixed
            verticalFittingPriority: .fittingSizeLevel
        ) // Height can be as large as needed
    }
}

// MARK: - UICollectionViewDataSource extension
extension DestinationsViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel?.destinations.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let desti = viewModel?.destinations[indexPath.item],
              let cell = collectionView
                  .dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? DestinationCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(destination: desti)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SectionHeaderView",
                for: indexPath
            ) as? SectionHeaderView else {
                return UICollectionReusableView()
            }
            headerView.setup(titleLabel: "Toutes nos destinations")
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegate extension
extension DestinationsViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let desti = viewModel?.destinations[indexPath.item] else {
            return
        }

        DestinationFetchingService().getDestinationDetails(for: desti.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(details):
                    print("coordinator => \(self?.coordinator)")
                    self?.coordinator?.goToDetails(name: desti.name, webViewURL: details.url)
                case let .failure(error):
                    let alert = UIAlertController(
                        title: "Erreur",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "Annuler", style: .cancel))

                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
