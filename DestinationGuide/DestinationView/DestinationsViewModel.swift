import Foundation

protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations() async
}

class DestinationsViewModel: DestinationsViewModelProtocol {
    private let useCase: FetchDestinationsUseCaseProtocol

    init(useCase: FetchDestinationsUseCaseProtocol) {
        self.useCase = useCase
    }

    func fetchDestinations() async {}
}
