import RxSwift

protocol FetchDestinationDetailsUseCaseProtocol {
    func execute(destinationID: String) async -> Result<DestinationDetails, DestinationFetchingServiceError>
}
