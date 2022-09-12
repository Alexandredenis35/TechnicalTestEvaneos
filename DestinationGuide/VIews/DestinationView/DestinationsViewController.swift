import RxSwift
import UIKit

// MARK: - DestinationsViewController
final class DestinationsViewController: UIViewController {
    // MARK: Constant

    private enum Constant {
        static let destinationCellIdentifier = "DestinationCollectionViewCell"
        static let headerViewIdentifier = "SectionHeaderView"
    }

    // MARK: IBOutlets

    @IBOutlet private var recentDestinationsStackView: UIStackView!
    @IBOutlet private var destinationsCollectionView: UICollectionView!

    // MARK: Properties

    private var disposeBag = DisposeBag()
    var viewModel: DestinationsViewModelProtocol?

    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 32, right: 0)
        layout.minimumLineSpacing = 32
        layout.itemSize = .init(width: 342, height: 280)
        return layout
    }()

    // MARK: View controller lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBinding()
    }

    // MARK: Private functions

    private func setupBinding() {
        viewModel?.recentDestinationsRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] recentDestinations in
                self?.recentDestinationsStackView.removeSubviews()
                recentDestinations.forEach { recentDestination in
                    let recentDestinationView = RecentDestinationView()
                    recentDestinationView.setup(delegate: self, details: recentDestination)
                    self?.recentDestinationsStackView.addArrangedSubview(recentDestinationView)
                }
            })
            .disposed(by: disposeBag)

        viewModel?.needToShowLoaderRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] needToShowLoader in
                if needToShowLoader {
                    self?.showLoader()
                } else {
                    self?.hideLoader()
                }
            })
            .disposed(by: disposeBag)

        viewModel?.destinationsRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.destinationsCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupCollectionView() {
        destinationsCollectionView.collectionViewLayout = collectionViewLayout
        destinationsCollectionView.dataSource = self
        destinationsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        destinationsCollectionView.delegate = self
        destinationsCollectionView.register(
            UINib(nibName: Constant.destinationCellIdentifier, bundle: nil),
            forCellWithReuseIdentifier: Constant.destinationCellIdentifier
        )
        destinationsCollectionView.register(
            UINib(nibName: Constant.headerViewIdentifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constant.headerViewIdentifier
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
        return viewModel?.destinationsRelay.value.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let desti = viewModel?.destinationsRelay.value[indexPath.item],
              let cell = collectionView
                  .dequeueReusableCell(
                      withReuseIdentifier: Constant.destinationCellIdentifier,
                      for: indexPath
                  ) as? DestinationCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = DestinationCellViewModel(
            destination: desti,
            fetchDestinationImageUseCase: FetchDestinationImageUseCase()
        )
        cell.setupCell(viewModel: viewModel)
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
                withReuseIdentifier: Constant.headerViewIdentifier,
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
        guard let selectedDestination = viewModel?.destinationsRelay.value[indexPath.item] else {
            return
        }
        Task {
            await viewModel?.fetchDestinationDetails(id: selectedDestination.id)
        }
    }
}

// MARK: - RecentDestinationProtocol extension
extension DestinationsViewController: RecentDestinationProtocol {
    func didSelectRecentDestination(id: String) {
        Task {
            await viewModel?.fetchDestinationDetails(id: id)
        }
    }
}
