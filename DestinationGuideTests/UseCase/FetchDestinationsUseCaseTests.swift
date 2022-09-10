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
                picture: URL(string: "")!,
                tag: "Incontournable",
                rating: 5
            ),
            .init(
                id: "50",
                name: "Arménie",
                picture: URL(string: "")!,
                tag: "Incontournable",
                rating: 4
            )
        ]
        mockedRepository.getDestinationsData = expectedResult
        sut.execute() // Here Single<Destinations>
    }

    override func tearDown() {
        super.tearDown()
        mockedRepository = nil
        sut = nil
    }
}
