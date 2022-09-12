protocol RecentDestinationUseCaseProtocol {
    func execute(details: DestinationDetails) -> [DestinationDetails]
}
