import Foundation

final class RecentDestinationUseCase: RecentDestinationUseCaseProtocol {
    var currentRecentDestinations: [DestinationDetails]

    init(currentRecentDestinations: [DestinationDetails]) {
        self.currentRecentDestinations = currentRecentDestinations
    }

    func execute(details: DestinationDetails) -> [DestinationDetails] {
        if !currentRecentDestinations.contains(details), currentRecentDestinations.count < 2 {
            currentRecentDestinations.append(details)
        } else if currentRecentDestinations.count >= 2 {
            currentRecentDestinations.removeFirst()
            currentRecentDestinations.append(details)
        }
        return currentRecentDestinations
    }
}
