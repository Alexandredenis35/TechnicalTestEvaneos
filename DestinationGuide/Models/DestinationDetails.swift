import Foundation

struct DestinationDetails: Hashable, Identifiable, Codable {
    let id: String
    let name: String
    let url: URL
}
