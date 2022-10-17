import Combine
import Foundation

// MARK: - DestinationsViewModelProtocol
protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations() async
    func fetchDestinationDetails(id: String) async
    func createCellViewModel(destination: Destination) -> DestinationCellViewModel
    var recentDestinationsRelay: CurrentValueSubject<[DestinationDetails], Never> { get }
    var destinationsRelay: CurrentValueSubject<[Destination], Never> { get }
    var needToShowLoaderRelay: CurrentValueSubject<Bool, Never> { get }
}

final class DestinationsViewModel: DestinationsViewModelProtocol {
    // MARK: Constant

    private enum Constant {
        static let errorTitle: String = "Erreur"
        static let recentDestinationsKey: String = "recentDestinations"
    }

    // MARK: Properties

    var recentDestinationsRelay: CurrentValueSubject<[DestinationDetails], Never>
    var destinationsRelay: CurrentValueSubject<[Destination], Never> = .init([])
    var needToShowLoaderRelay: CurrentValueSubject<Bool, Never> = .init(true)

    weak var coordinator: AppCoordinator?

    private let destinationsUseCase: FetchDestinationsUseCaseProtocol
    private let destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol
    private let recentDestinationsUseCase: GetRecentDestinationUseCaseProtocol
    private let storageService: UserDefaultStorageServiceProtocol

    // MARK: Initialisation

    init(
        destinationsUseCase: FetchDestinationsUseCaseProtocol,
        destinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol,
        recentDestinationsUseCase: GetRecentDestinationUseCaseProtocol,
        storageService: UserDefaultStorageServiceProtocol,
        coordinator: AppCoordinator?
    ) {
        self.destinationsUseCase = destinationsUseCase
        self.destinationDetailsUseCase = destinationDetailsUseCase
        self.recentDestinationsUseCase = recentDestinationsUseCase
        self.coordinator = coordinator
        self.storageService = storageService
        let data = storageService.getValueFromKey(Constant.recentDestinationsKey)
        let recentDestinations: [DestinationDetails] = CodableUtils.parse(data: data)
        recentDestinationsRelay = .init(recentDestinations)
        Task {
            await fetchDestinations()
        }
    }

    // MARK: Public Functions

    func fetchDestinations() async {
        needToShowLoaderRelay.send(true)
        let result = await destinationsUseCase.execute()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.needToShowLoaderRelay.send(false)
            switch result {
            case let .success(destinations):
                self.destinationsRelay.send(Array(destinations))
            case let .failure(error):
                self.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }
        }
    }

    func fetchDestinationDetails(id: String) async {
        needToShowLoaderRelay.send(true)
        let result = await destinationDetailsUseCase.execute(destinationID: id)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.needToShowLoaderRelay.send(false)
            switch result {
            case let .success(destinationDetails):
                let recentDestinations = self.getRecentDestinations(destinationDetails)
                self.recentDestinationsRelay.send(recentDestinations)
                self.coordinator?.goToDetails(name: destinationDetails.name, webViewURL: destinationDetails.url)
            case let .failure(error):
                self.coordinator?.showAlert(
                    alertTitle: Constant.errorTitle,
                    alertMessage: error.localizedDescription
                )
            }
        }
    }

    func createCellViewModel(destination: Destination) -> DestinationCellViewModel {
        let repository = DestinationsRepository(dataSource: DestinationFetchingService())
        let fetchDestinationImageUseCase = FetchDataRequestUseCase(repository: repository)
        let viewModel = DestinationCellViewModel(
            destination: destination,
            fetchDestinationImageUseCase: fetchDestinationImageUseCase
        )
        return viewModel
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
        storageService.setValue(data)
    }
}
