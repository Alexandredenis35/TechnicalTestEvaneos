import Foundation
import RxSwift

protocol FetchDestinationsUseCaseProtocol {
    func execute() async -> Result<Set<Destination>, DestinationFetchingServiceError>
}
