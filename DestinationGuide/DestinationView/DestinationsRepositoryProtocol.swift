import Foundation

protocol DestinationsRepositoryProtocol {
    func getDestinations() async -> Result<Set<Destination>, DestinationFetchingServiceError>
}
