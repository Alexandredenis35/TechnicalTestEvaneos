import Foundation
import RxSwift

struct DestinationsRepository: DestinationsRepositoryProtocol {
    var dataSource: DestinationFetchingServiceProtocol

    func getDestinationsDetails(destinationID: String) -> Single<DestinationDetails> {
        return Single.create { observer in
            dataSource.getDestinationDetails(for: destinationID) { result in
                switch result {
                case let .success(value):
                    observer(.success(value))
                case let .failure(error):
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func getDestinations() -> Single<[Destination]> {
        return Single.create { observer in
            dataSource.getDestinations { result in
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
