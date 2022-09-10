import Foundation

class CodableUtils {
    static func parse<T: Codable>(data: Data?) -> [T] {
        guard let data = data else {
            return []
        }
        return (try? JSONDecoder().decode([T].self, from: data)) ?? []
    }
}
