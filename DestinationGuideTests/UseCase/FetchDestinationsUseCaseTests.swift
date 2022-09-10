@testable import DestinationGuide
import Foundation
import RxSwift
import XCTest

class FetchDestinationsUseCaseTests: XCTestCase {
    var sut: FetchDestinationsUseCase!
    var mockedRepository: MockDestinationsRepository!

    override func setUp() {
        mockedRepository = MockDestinationsRepository()
        sut = FetchDestinationsUseCase(repository: mockedRepository)
    }

    func tests_useCase_with_data() async {
        let expectedResult: Set<Destination> = [
            .init(
                id: "217",
                name: "Barbade",
                picture: URL(string: "https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!,
                tag: "Incontournable",
                rating: 5
            ),
            .init(
                id: "50",
                name: "Arménie",
                picture: URL(string: "https://static1.evcdn.net/images/reduction/1544481_w-800_h-800_q-70_m-crop.jpg")!,
                tag: "Incontournable",
                rating: 4
            )
        ]
        
        mockedRepository.getDestinationsUseCaseData = expectedResult
        sut.execute()
    }

    override func tearDown() {
        super.tearDown()
        mockedRepository = nil
        sut = nil
    }
}
