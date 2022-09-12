struct FetchDestinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute(destinationID: String) async -> Result<DestinationDetails, DestinationFetchingServiceError> {
        await repository.getDestinationDetails(destinationID: destinationID)
    }
}
