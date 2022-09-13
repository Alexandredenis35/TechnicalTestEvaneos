import Foundation

final class GetRecentDestinationUseCase: GetRecentDestinationUseCaseProtocol {
    func execute(
        newRecentDestinations: DestinationDetails,
        currentRecentDestinations: [DestinationDetails]
    ) -> [DestinationDetails] {
        var destinations = currentRecentDestinations
        if let index = destinations.firstIndex(where: { $0 == newRecentDestinations }) {
            destinations.remove(at: index)
        }

        if destinations.count >= 2 {
            destinations.removeFirst()
        }

        destinations.append(newRecentDestinations)
        return destinations
    }
}
