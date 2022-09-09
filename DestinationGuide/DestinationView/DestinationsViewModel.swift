import Foundation

protocol DestinationsViewModelProtocol: AnyObject {
    func fetchDestinations() async
}

class DestinationsViewModel: DestinationsViewModelProtocol {
    private let useCase: FetchDestinationsUseCaseProtocol?
    var destinations: [Destination] = []

    init(useCase: FetchDestinationsUseCaseProtocol? = nil) {
        self.useCase = useCase
    }

    func fetchDestinations() async {}
}
