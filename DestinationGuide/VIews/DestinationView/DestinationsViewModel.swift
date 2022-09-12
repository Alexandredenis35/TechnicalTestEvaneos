import Foundation
import RxRelay
import RxSwift

// MARK: - DestinationsViewModelProtocol
protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations() async
    func fetchDestinationDetails(id: String) async
    var recentDestinationsRelay: BehaviorRelay<[DestinationDetails]> { get }
    var destinationsRelay: BehaviorRelay<[Destination]> { get }
    var needToShowLoaderRelay: BehaviorRelay<Bool> { get }
}

final class DestinationsViewModel: DestinationsViewModelProtocol {
    // MARK: Constant

    private enum Constant {
        static let errorTitle: String = "Erreur"
        static let recentDestinationsKey: String = "recentDestinations"
    }

    // MARK: Properties

    var recentDestinationsRelay: BehaviorRelay<[DestinationDetails]>
    var destinationsRelay: BehaviorRelay<[Destination]> = .init(value: [])
    var needToShowLoaderRelay: BehaviorRelay<Bool> = .init(value: true)
    weak var coordinator: AppCoordinator?

    private let destinationsUseCase: FetchDestinationsUseCaseProtocol
    private let destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol
    private let recentDestinationsUseCase: RecentDestinationUseCaseProtocol
    private let disposeBag: DisposeBag = .init()

    // MARK: Initialisation

    init(
        destinationsUseCase: FetchDestinationsUseCaseProtocol,
        destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol,
        recentDestinationsUseCase: RecentDestinationUseCaseProtocol,
        coordinator: AppCoordinator?
    ) {
        self.destinationsUseCase = destinationsUseCase
        self.destinationDetailsUseCase = destinationDetailsUseCase
        self.recentDestinationsUseCase = recentDestinationsUseCase
        self.coordinator = coordinator
        let data = UserDefaults.standard.data(forKey: Constant.recentDestinationsKey)
        let recentDestinations: [DestinationDetails] = CodableUtils.parse(data: data)
        recentDestinationsRelay = .init(value: recentDestinations)
        Task {
            await fetchDestinations()
        }
    }

    // MARK: Public Functions

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
                let recentDestinations = self.getRecentDestinations(destinationDetails)
                self.recentDestinationsRelay.accept(recentDestinations)
                self.coordinator?.goToDetails(name: destinationDetails.name, webViewURL: destinationDetails.url)
            case let .failure(error):
                self.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }
        }
    }

    // MARK: Private functions

    private func getRecentDestinations(_ details: DestinationDetails) -> [DestinationDetails] {
        let destinationDetails = recentDestinationsUseCase.execute(
            newRecentDestinations: details,
            currentRecentDestinations: recentDestinationsRelay.value
        )
        saveDestinationsUserDefault(destinations: destinationDetails)
        return destinationDetails
    }

    private func saveDestinationsUserDefault(destinations: [DestinationDetails]) {
        let data = CodableUtils.encode(object: destinations)
        UserDefaults.standard.set(data, forKey: Constant.recentDestinationsKey)
    }
}
