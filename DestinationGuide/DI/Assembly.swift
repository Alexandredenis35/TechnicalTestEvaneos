import Foundation
import Swinject

class DestinationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DestinationFetchingServiceProtocol.self) { _ in
            DestinationFetchingService()
        }
        container.register(DestinationsRepositoryProtocol.self) { _ in
            DestinationsRepository(dataSource: container.resolve(DestinationFetchingServiceProtocol.self))
        }
        container.register(FetchDestinationsUseCaseProtocol.self) { _ in
            FetchDestinationsUseCase(repository: container.resolve(DestinationsRepositoryProtocol.self))
        }
    }
}

class DestinationDetailsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DestinationFetchingServiceProtocol.self) { _ in
            DestinationFetchingService()
        }
        container.register(DestinationsRepository.self) { _ in
            DestinationsRepository(dataSource: container.resolve(DestinationFetchingServiceProtocol.self))
        }
        container.register(FetchDestinationDetailsUseCaseProtocol.self) { _ in
            FetchDestinationDetailsUseCase(repository: container.resolve(DestinationsRepositoryProtocol.self))
        }
    }
}
