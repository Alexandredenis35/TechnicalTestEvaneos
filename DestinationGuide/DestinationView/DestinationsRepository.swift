import Foundation

struct DestinationsRepository: DestinationsRepositoryProtocol {
    func getDestinations() async -> Result<Set<Destination>, DestinationFetchingServiceError> {
        let service = DestinationFetchingService()
        let destinationSet: Set = [Destination(id: "", name: "", picture: URL(string: "")!, tag: "", rating: 3)]
        return .success(destinationSet)
    }
}
