@testable import DestinationGuide
import Foundation

final class MockDestinationsRepository: DestinationsRepositoryProtocol {
    var getDestinationsUseCaseError: DestinationFetchingServiceError?
    var getDestinationsUseCaseData: Set<Destination>?
    var getDestinationsUseCaseGotCalled: Bool = false

    func getDestinations() async -> Result<Set<Destination>, DestinationFetchingServiceError> {
        getDestinationsUseCaseGotCalled = true
        if getDestinationsUseCaseData != nil,
           let destinations = getDestinationsUseCaseData {
            return .success(destinations)
        } else {
            return .failure(getDestinationsUseCaseError ?? .destinationNotFound)
        }
    }

    var getDestinationDetailsUseCaseError: DestinationFetchingServiceError?
    var getDestinationDetailsUseCaseData: DestinationDetails?
    var getDestinationDetailsUseCaseGotCalled: Bool = false
    var getDestinationDetailsGotCalledWith: String?

    func getDestinationDetails(destinationID: String) async
    -> Result<DestinationDetails, DestinationFetchingServiceError> {
        getDestinationDetailsGotCalledWith = destinationID
        getDestinationDetailsUseCaseGotCalled = true

        if getDestinationDetailsUseCaseData != nil,
           let destinationDetails = getDestinationDetailsUseCaseData {
            return .success(destinationDetails)
        } else {
            return .failure(getDestinationsUseCaseError ?? .destinationNotFound)
        }
    }
}
