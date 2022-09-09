import Foundation

struct FetchDestinationsUseCase: FetchDestinationsUseCaseProtocol {
    func execute() async -> Result<Set<Destination>, DestinationFetchingServiceError> {
        let destinationSet: Set = [Destination(id: "", name: "", picture: URL(string: "")!, tag: "", rating: 3)]
        return .success(destinationSet)
    }
}
