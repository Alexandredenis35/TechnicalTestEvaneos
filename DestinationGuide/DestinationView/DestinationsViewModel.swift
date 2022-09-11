import Foundation
import RxCocoa
import RxRelay
import RxSwift
import UIKit

protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations() async
    func fetchDestinationDetails(id: String) async
}

final class DestinationsViewModel: DestinationsViewModelProtocol {
    private enum Constant {
        static let errorTitle: String = "Erreur"
        static let recentDestinationsKey: String = "recentDestinations"
    }

    private let destinationsUseCase: FetchDestinationsUseCaseProtocol
    private let destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol

    private let disposeBag: DisposeBag = .init()
    // private var recentDestinationsDetails: [DestinationDetails] = []

    var recentDestinationsRelay: BehaviorRelay<[DestinationDetails]>
    var destinationsRelay: BehaviorRelay<[Destination]> = .init(value: [])
    var needToShowLoaderRelay: BehaviorRelay<Bool> = .init(value: true)

    weak var coordinator: AppCoordinator?

    init(
        destinationsUseCase: FetchDestinationsUseCaseProtocol,
        destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol,
        coordinator: AppCoordinator?
    ) {
        self.destinationsUseCase = destinationsUseCase
        self.destinationDetailsUseCase = destinationDetailsUseCase
        self.coordinator = coordinator

        let data = UserDefaults.standard.data(forKey: Constant.recentDestinationsKey)
        let recentDestinations: [DestinationDetails] = CodableUtils.parse(data: data)
        recentDestinationsRelay = .init(value: recentDestinations)

        Task {
            await fetchDestinations()
        }
    }

    func fetchDestinations() async {
        needToShowLoaderRelay.accept(true)
        let result = await destinationsUseCase.execute()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.needToShowLoaderRelay.accept(false)
            switch result {
            case let .success(destinations):
                self.destinationsRelay.accept(Array(destinations))
            case let .failure(error):
                self.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }
        }
    }

    func fetchDestinationDetails(id: String) async {
        needToShowLoaderRelay.accept(true)
        let result = await destinationDetailsUseCase.execute(destinationID: id)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.needToShowLoaderRelay.accept(false)
            switch result {
            case let .success(destinationDetails):
                self.addRecentDestination(destinationDetails)
                self.coordinator?.goToDetails(name: destinationDetails.name, webViewURL: destinationDetails.url)
            case let .failure(error):
                self.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }
        }
    }

    private func addRecentDestination(_ details: DestinationDetails) {
        var recentDestinations = recentDestinationsRelay.value
        if !recentDestinationsRelay.value.contains(details), recentDestinationsRelay.value.count < 2 {
            recentDestinations.append(details)
        } else if recentDestinationsRelay.value.count >= 2 {
            recentDestinations.removeFirst()
        }
        let data = CodableUtils.encode(object: recentDestinations)
        UserDefaults.standard.set(data, forKey: Constant.recentDestinationsKey)
        recentDestinationsRelay.accept(recentDestinations)
    }
}
