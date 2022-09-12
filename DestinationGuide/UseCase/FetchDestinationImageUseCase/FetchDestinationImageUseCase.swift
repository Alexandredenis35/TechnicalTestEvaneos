import Foundation
import UIKit

struct FetchDestinationImageUseCase: FetchDestinationImageUseCaseProtocol {
    func execute(url: URL) async -> UIImage? {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
