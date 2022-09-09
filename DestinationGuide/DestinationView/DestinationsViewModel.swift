import Foundation
import RxRelay
import RxSwift
import UIKit

protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations()
    func fetchDestinationDetails(id: String, parentVC: UIViewController)
}

class DestinationsViewModel: DestinationsViewModelProtocol {
    private let destinationsUseCase: FetchDestinationsUseCaseProtocol
    private let destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol
    private let disposeBag: DisposeBag = .init()
    var destinationsRelay: BehaviorRelay<[Destination]> = .init(value: [])

    weak var coordinator: AppCoordinator?

    init(
        destinationsUseCase: FetchDestinationsUseCaseProtocol,
        destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol,
        coordinator: AppCoordinator?
    ) {
        self.destinationsUseCase = destinationsUseCase
        self.destinationDetailsUseCase = destinationDetailsUseCase
        self.coordinator = coordinator
        fetchDestinations()
    }

    func fetchDestinations() {
        destinationsUseCase.execute()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] destinations in
                self?.destinationsRelay.accept(destinations)
            }, onFailure: { error in
                guard let error = error as? DestinationFetchingServiceError else {
                    return
                }
                // TODO: Handle Error case
            }).disposed(by: disposeBag)
    }

    func fetchDestinationDetails(id: String, parentVC: UIViewController) {
        destinationDetailsUseCase.execute(destinationID: id)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] destinationDetails in
                print("destinationDetails => \(destinationDetails)")
                self?.coordinator?.goToDetails(name: destinationDetails.name, webViewURL: destinationDetails.url)
                // TODO: go to detailView
            }, onFailure: { [weak self] error in
                self?.coordinator?.showAlert(
                    parentVC: parentVC,
                    alertTitle: "Erreur",
                    alertMessage: error.localizedDescription
                )

            }).disposed(by: disposeBag)
    }
}
