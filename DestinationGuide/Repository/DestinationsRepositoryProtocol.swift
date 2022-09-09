import Foundation
import RxSwift

protocol DestinationsRepositoryProtocol {
    func getDestinations() -> Single<[Destination]>
    func getDestinationsDetails(destinationID: String) -> Single<DestinationDetails>
}
