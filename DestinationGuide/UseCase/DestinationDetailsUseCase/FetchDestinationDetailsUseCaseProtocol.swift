import RxSwift

protocol FetchDestinationDetailsUseCaseProtocol {
    func execute(destinationID: String) -> Single<DestinationDetails>
}
