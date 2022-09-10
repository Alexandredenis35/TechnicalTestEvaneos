@testable import DestinationGuide
import Foundation
import RxSwift

class MockDestinationsRepository: DestinationsRepositoryProtocol {
    var getDestinationsUseCaseError: Error?
    var getDestinationsUseCaseData: Set<Destination>?
    var getDestinationsUseCaseGotCalled: Bool = false

    func getDestinations() -> Single<[Destination]> {
        getDestinationsUseCaseGotCalled = true
        if getDestinationsUseCaseError != nil,
           let destinations = getDestinationsUseCaseData {
            return Single.just(Array(destinations))
        } else if let error = getDestinationsUseCaseError {
            return Single.error(error)
        } else {
            return Single.error(NSError(domain: "Not Found", code: 404))
        }
    }

    var getDestinationDetailsUseCaseError: Error?
    var getDestinationsDetailsUseCaseData: DestinationDetails?
    var getDestinationsDetailsUseCaseGotCalled: Bool = false

    func getDestinationDetails(destinationID _: String) -> Single<DestinationDetails> {
        getDestinationsDetailsUseCaseGotCalled = true
        if getDestinationsDetailsUseCaseData != nil,
           let destinationDetails = getDestinationsDetailsUseCaseData {
            return Single.just(destinationDetails)
        } else if let error = getDestinationDetailsUseCaseError {
            return Single.error(error)
        } else {
            return Single.error(NSError(domain: "Not Found", code: 404))
        }
    }
}
