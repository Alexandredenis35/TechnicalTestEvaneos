import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainVC = DestinationsViewController.instantiate()
        let destinationsUseCase =
            FetchDestinationsUseCase(repository: DestinationsRepository(dataSource: DestinationFetchingService()))
        let destinationDetailUseCase =
            FetchDestinatioDetailsUseCase(repository: DestinationsRepository(dataSource: DestinationFetchingService()))
        let viewModel = DestinationsViewModel(
            destinationsUseCase: destinationsUseCase,
            destinationDetailsUseCase: destinationDetailUseCase,
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
        parentVC: UIViewController,
        alertTitle: String,
        alertMessage: String
    ) {
        let alert = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel))

        parentVC.present(alert, animated: true)
    }
}
