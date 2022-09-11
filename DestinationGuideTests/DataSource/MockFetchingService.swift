@testable import DestinationGuide
import Foundation

final class MockFetchingService: DestinationFetchingServiceProtocol {
    var getDestinationsError: DestinationFetchingServiceError?
    var getDestinationsData: Set<Destination>?
    var getDestinationsGotCalled: Bool = false

    func getDestinations(completion: @escaping (Result<Set<Destination>, DestinationFetchingServiceError>) -> Void) {
        getDestinationsGotCalled = true
        if getDestinationsError == nil,
           let destinations = getDestinationsData {
            completion(.success(destinations))
        } else if let error = getDestinationsError {
            completion(.failure(error))
        }
    }

    var getDestinationDetailsError: DestinationFetchingServiceError?
    var getDestinationDetailsData: DestinationDetails?
    var getDestinationDetailsGotCalled: Bool = false
    var getDestinationDetailsGotCalledWith: String?

    func getDestinationDetails(
        for destinationID: Destination.ID,
        completion: @escaping (Result<DestinationDetails, DestinationFetchingServiceError>) -> Void
    ) {
        getDestinationDetailsGotCalledWith = destinationID
        getDestinationDetailsGotCalled = true
        if getDestinationDetailsError == nil,
           let destinations = getDestinationDetailsData {
            completion(.success(destinations))
        } else if let error = getDestinationDetailsError {
            completion(.failure(error))
        }
    }
}
