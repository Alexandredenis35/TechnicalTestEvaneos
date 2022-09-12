import Foundation
import UIKit

protocol DestinationCellViewModelProtocol {
    var destination: Destination { get }
    func downloadImage(url: URL) async -> UIImage?
}

struct DestinationCellViewModel: DestinationCellViewModelProtocol {
    let destination: Destination
    let fetchDestinationImageUseCase: FetchDestinationImageUseCaseProtocol

    func downloadImage(url: URL) async -> UIImage? {
        let image = await fetchDestinationImageUseCase.execute(url: url)
        return image
    }
}
