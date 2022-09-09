import Foundation

struct Destination: Hashable, Identifiable, Encodable {
    let id: String
    let name: String
    let picture: URL
    let tag: String?
    let rating: Int
}

extension Array where Element == Destination {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
