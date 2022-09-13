import Foundation

struct DestinationsRepository: DestinationsRepositoryProtocol {
    var dataSource: DestinationFetchingServiceProtocol

    func getDestinationDetails(destinationID: String) async
    -> Result<DestinationDetails, DestinationFetchingServiceError> {
        await withCheckedContinuation { continuation in
            dataSource.getDestinationDetails(for: destinationID, completion: { result in
                continuation.resume(returning: result)
            })
        }
    }

    func getDestinations() async -> Result<Set<Destination>, DestinationFetchingServiceError> {
        await withCheckedContinuation { continuation in
            dataSource.getDestinations { result in
                continuation.resume(returning: result)
            }
        }
    }

    func getDataRequest(url: URL) async -> Data? {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return nil
        }
        return data
    }
}
