import Foundation
import RxSwift

protocol DestinationsRepositoryProtocol {
    func getDestinations() -> Single<[Destination]>
}
