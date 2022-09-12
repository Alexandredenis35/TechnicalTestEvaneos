protocol RecentDestinationUseCaseProtocol {
    func execute(
        newRecentDestinations: DestinationDetails,
        currentRecentDestinations: [DestinationDetails]
    ) -> [DestinationDetails]
}
