import Foundation
import RxSwift

struct DestinationsRepository: DestinationsRepositoryProtocol {
    func getDestinations() -> Single<[Destination]> {
        let service = DestinationFetchingService()
        return Single.create { observer in
            service.getDestinations { result in
                switch result {
                case let .success(value):
                    observer(.success(Array(value)))
                case let .failure(error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
