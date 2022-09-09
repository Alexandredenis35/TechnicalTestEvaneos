import RxSwift

struct FetchDestinatioDetailsUseCase: FetchDestinationDetailsUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute(destinationID: String) -> Single<DestinationDetails> {
        return repository.getDestinationsDetails(destinationID: destinationID)
    }
}
