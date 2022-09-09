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
        let viewModel = DestinationsViewModel()
        mainVC.viewModel = viewModel
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: false)
    }

    func goToDetails(name: String, webViewURL: URL) {
        let detailsVC = DestinationDetailsViewController.instantiate()
        let viewModel = DestinationDetailsViewModel(name: name, webviewUrl: webViewURL)
        detailsVC.viewModel = viewModel
        navigationController.pushViewController(detailsVC, animated: false)
    }
}
