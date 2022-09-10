import Foundation
import RxCocoa
import RxRelay
import RxSwift
import UIKit

protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations()
    func fetchDestinationDetails(id: String)
}

final class DestinationsViewModel: DestinationsViewModelProtocol {
    private enum Constant {
        static let errorTitle: String = "Erreur"
    }

    private let destinationsUseCase: FetchDestinationsUseCaseProtocol
    private let destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol
    private let disposeBag: DisposeBag = .init()
    var destinationsDriver: Driver<[Destination]>
    var destinationsRelay: BehaviorRelay<[Destination]> = .init(value: [])
    var needToShowLoader: BehaviorRelay<Bool> = .init(value: true)
    weak var coordinator: AppCoordinator?

    init(
        destinationsUseCase: FetchDestinationsUseCaseProtocol,
        destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol,
        coordinator: AppCoordinator?
    ) {
        self.destinationsUseCase = destinationsUseCase
        self.destinationDetailsUseCase = destinationDetailsUseCase
        self.coordinator = coordinator
        destinationsDriver = destinationsRelay.asDriver()
        fetchDestinations()
    }

    func fetchDestinations() {
        destinationsUseCase.execute()
            .do(onSubscribe: { [weak self] in self?.needToShowLoader.accept(true) })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] destinations in
                self?.destinationsRelay.accept(destinations)
                self?.needToShowLoader.accept(false)
            }, onFailure: { [weak self] error in
                self?.needToShowLoader.accept(false)
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
