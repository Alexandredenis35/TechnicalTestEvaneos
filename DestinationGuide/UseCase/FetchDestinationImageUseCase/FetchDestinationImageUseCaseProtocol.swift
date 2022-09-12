import Foundation
import UIKit

protocol FetchDestinationImageUseCaseProtocol {
    func execute(url: URL) async -> UIImage?
}
