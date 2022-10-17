import Foundation

protocol UserDefaultStorageServiceProtocol {
    var key: String { get }
    func getValueFromKey(_ key: String) -> Data?
    func setValue(_ value: Data?)
}

struct UserDefaultStorageService: UserDefaultStorageServiceProtocol {
    private let userDefault: UserDefaults = .standard

    var key: String {
        return "recentDestinations"
    }

    func getValueFromKey(_ key: String) -> Data? {
        userDefault.data(forKey: key)
    }

    func setValue(_ data: Data?) {
        userDefault.set(data, forKey: key)
    }
}
