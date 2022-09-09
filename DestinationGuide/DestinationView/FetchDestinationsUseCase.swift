import Foundation
import RxSwift

struct FetchDestinationsUseCase: FetchDestinationsUseCaseProtocol {
    func execute() -> Single<[Destination]> {
        let destinationSet = [Destination(id: "", name: "", picture: URL(string: "")!, tag: "", rating: 3)]
        return Single.just(destinationSet)
    }
}
