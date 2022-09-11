import Foundation

class CodableUtils {
    static func parse<T: Decodable>(data: Data?) -> [T] {
        guard let data = data else {
            return []
        }
        return (try? JSONDecoder().decode([T].self, from: data)) ?? []
    }

    static func encode<T: Encodable>(object: T) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(object)
    }
}
