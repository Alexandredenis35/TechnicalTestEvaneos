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
    private var recentDestinationsDetails: [DestinationDetails] = []

    var recentDestinationsRelay: BehaviorRelay<[DestinationDetails]> = .init(value: [])

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
        fetchDestinations()
    }

    func fetchDestinations() {
        destinationsUseCase.execute()
            .observe(on: MainScheduler.instance)
            .do(onSubscribe: { [weak self] in self?.needToShowLoader.accept(true) })
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
            .do(onSubscribe: { [weak self] in self?.needToShowLoader.accept(true) })
            .subscribe(onSuccess: { [weak self] destinationDetails in
                self?.addRecentDestination(destinationDetails)
                self?.needToShowLoader.accept(false)
                self?.coordinator?.goToDetails(name: destinationDetails.name, webViewURL: destinationDetails.url)
            }, onFailure: { [weak self] error in
                self?.needToShowLoader.accept(false)
                self?.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }).disposed(by: disposeBag)
    }

    private func addRecentDestination(_ details: DestinationDetails) {
        if recentDestinationsDetails.count >= 2 {
            recentDestinationsDetails.removeFirst()
        }
        recentDestinationsDetails.append(details)
        recentDestinationsRelay.accept(recentDestinationsDetails)
    }
}
