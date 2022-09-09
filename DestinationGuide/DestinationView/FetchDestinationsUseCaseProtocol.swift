import Foundation
import RxSwift

protocol FetchDestinationsUseCaseProtocol {
    func execute() -> Single<[Destination]>
}
