import Foundation

final class RecentDestinationUseCase: RecentDestinationUseCaseProtocol {
    var currentRecentDestinations: [DestinationDetails]

    init(currentRecentDestinations: [DestinationDetails]) {
        self.currentRecentDestinations = currentRecentDestinations
    }

    func execute(details: DestinationDetails) -> [DestinationDetails] {
        if let index = currentRecentDestinations.firstIndex(where: { $0 == details }) {
            currentRecentDestinations.remove(at: index)
        }

        if currentRecentDestinations.count >= 2 {
            currentRecentDestinations.removeFirst()
        }

        currentRecentDestinations.append(details)

        return currentRecentDestinations
    }
}
