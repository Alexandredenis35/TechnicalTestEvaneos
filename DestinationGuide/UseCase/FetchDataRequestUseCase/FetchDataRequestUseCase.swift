import Foundation

struct FetchDataRequestUseCase: FetchDataRequestUseCaseProtocol {
    // TODO: Write UT for this UseCase	
    func execute(url: URL) async -> Data? {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return nil
        }
        return data
    }
}
