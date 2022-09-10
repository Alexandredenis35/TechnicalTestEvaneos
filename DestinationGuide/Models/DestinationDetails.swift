import Foundation

struct DestinationDetails: Hashable, Identifiable, Codable {
    let id: String
    let name: String
    let url: URL
}

extension Array where Element == DestinationDetails {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }

    func decode(data: Data?) -> [DestinationDetails] {
        let decoder = JSONDecoder()

        guard let data = data,
              let recentDestinations = try? decoder.decode([DestinationDetails].self, from: data) else {
            return []
        }
        return recentDestinations
    }
}
