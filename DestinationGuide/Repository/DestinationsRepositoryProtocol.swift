import Foundation
import RxSwift

protocol DestinationsRepositoryProtocol {
    func getDestinations() -> Single<[Destination]>
    func getDestinationDetails(destinationID: String) -> Single<DestinationDetails>
}
