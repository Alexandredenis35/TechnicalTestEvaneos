import Foundation

protocol FetchDestinationsUseCaseProtocol {
    func execute() async -> Result<Set<Destination>, DestinationFetchingServiceError>
}
