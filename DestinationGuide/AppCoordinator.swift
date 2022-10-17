import Foundation
import UIKit

// MARK: - CoordinatorProtocol
protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

// MARK: - AppCoordinator
final class AppCoordinator {
    // MARK: Properties

    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController

    // MARK: Initialisation

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol extension
extension AppCoordinator: CoordinatorProtocol {
    func start() {
        let mainVC = DestinationsViewController.instantiate()
        let destinationsUseCase =
            FetchDestinationsUseCase(repository: DestinationsRepository(dataSource: DestinationFetchingService()))
        let destinationDetailUseCase =
            FetchDestinationDetailsUseCase(repository: DestinationsRepository(dataSource: DestinationFetchingService()))

        let recentDestinationUseCase = GetRecentDestinationUseCase()
        let viewModel = DestinationsViewModel(
            destinationsUseCase: destinationsUseCase,
            destinationDetailsUseCase: destinationDetailUseCase,
            recentDestinationsUseCase: recentDestinationUseCase,
            storageService: UserDefaultStorageService(),
            coordinator: self
        )
        mainVC.viewModel = viewModel
        navigationController.pushViewController(mainVC, animated: false)
    }

    func goToDetails(name: String, webViewURL: URL) {
        let detailsVC = DestinationDetailsViewController.instantiate()
        let viewModel = DestinationDetailsViewModel(name: name, webviewUrl: webViewURL)
        detailsVC.viewModel = viewModel
        navigationController.pushViewController(detailsVC, animated: false)
    }

    func showAlert(
        alertTitle: String,
        alertMessage: String
    ) {
        let alert = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel))
        navigationController.viewControllers.last?.present(alert, animated: true)
    }
}
