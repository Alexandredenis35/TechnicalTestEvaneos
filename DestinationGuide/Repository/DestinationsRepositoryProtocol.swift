import Foundation
import RxSwift

protocol DestinationsRepositoryProtocol {
    func getDestinations() async -> Result<Set<Destination>, DestinationFetchingServiceError>
    func getDestinationDetails(destinationID: String) async
        -> Result<DestinationDetails, DestinationFetchingServiceError>
}
