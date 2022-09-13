import Foundation

protocol FetchDataRequestUseCaseProtocol {
    func execute(url: URL) async -> Data?
}
