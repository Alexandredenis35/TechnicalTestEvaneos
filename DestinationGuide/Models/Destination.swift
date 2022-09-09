import Foundation

struct Destination: Hashable, Identifiable {
    let id: String
    let name: String
    let picture: URL
    let tag: String?
    let rating: Int
}
