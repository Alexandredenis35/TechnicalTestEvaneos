import Foundation

protocol DestinationCellViewModelProtocol {
    var destination: Destination { get }
    func downloadImage(url: URL) async -> Data?
}

struct DestinationCellViewModel: DestinationCellViewModelProtocol {
    let destination: Destination
    let fetchDestinationImageUseCase: FetchDataRequestUseCaseProtocol

    func downloadImage(url: URL) async -> Data? {
        let data = await fetchDestinationImageUseCase.execute(url: url)
        return data
    }
}
