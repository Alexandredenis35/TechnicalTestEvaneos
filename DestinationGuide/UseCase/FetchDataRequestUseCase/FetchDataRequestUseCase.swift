import Foundation

struct FetchDataRequestUseCase: FetchDataRequestUseCaseProtocol {
    // TODO: Write UT for this UseCase
    var repository: DestinationsRepositoryProtocol

    func execute(url: URL) async -> Data? {
        await repository.getDataRequest(url: url)
    }
}
