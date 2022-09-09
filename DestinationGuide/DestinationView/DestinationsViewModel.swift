import Foundation
import RxRelay
import RxSwift
import UIKit

protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations()
    func fetchDestinationDetails(id: String)
}

class DestinationsViewModel: DestinationsViewModelProtocol {
    private enum Constant {
        static let errorTitle: String = "Erreur"
    }

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
            }, onFailure: { [weak self] error in
                self?.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }).disposed(by: disposeBag)
    }

    func fetchDestinationDetails(id: String) {
        destinationDetailsUseCase.execute(destinationID: id)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] destinationDetails in
                self?.coordinator?.goToDetails(name: destinationDetails.name, webViewURL: destinationDetails.url)
            }, onFailure: { [weak self] error in
                self?.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }).disposed(by: disposeBag)
    }
}
