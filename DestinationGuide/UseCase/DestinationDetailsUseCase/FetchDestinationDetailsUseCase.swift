import RxSwift

struct FetchDestinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute(destinationID: String) -> Single<DestinationDetails> {
        return repository.getDestinationDetails(destinationID: destinationID)
    }
}
