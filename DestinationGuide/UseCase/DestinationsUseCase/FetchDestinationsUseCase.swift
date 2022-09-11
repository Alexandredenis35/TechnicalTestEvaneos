import Foundation

struct FetchDestinationsUseCase: FetchDestinationsUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute() async -> Result<Set<Destination>, DestinationFetchingServiceError> {
        return await repository.getDestinations()
    }
}
