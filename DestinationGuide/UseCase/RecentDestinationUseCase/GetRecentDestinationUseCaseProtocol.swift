protocol GetRecentDestinationUseCaseProtocol {
    func execute(
        newRecentDestinations: DestinationDetails,
        currentRecentDestinations: [DestinationDetails]
    ) -> [DestinationDetails]
}
