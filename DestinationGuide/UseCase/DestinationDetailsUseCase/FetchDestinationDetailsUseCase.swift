import RxSwift

struct FetchDestinatioDetailsUseCase: FetchDestinationDetailsUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute(destinationID: String) -> Single<DestinationDetails> {
        return repository.getDestinationDetails(destinationID: destinationID)
    }
}
