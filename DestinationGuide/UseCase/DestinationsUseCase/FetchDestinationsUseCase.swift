import Foundation
import RxSwift

struct FetchDestinationsUseCase: FetchDestinationsUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute() -> Single<[Destination]> {
        return repository.getDestinations()
    }
}
