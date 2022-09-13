import Foundation

struct FetchDataRequestUseCase: FetchDataRequestUseCaseProtocol {
    var repository: DestinationsRepositoryProtocol

    func execute(url: URL) async -> Data? {
        await repository.getDataRequest(url: url)
    }
}
