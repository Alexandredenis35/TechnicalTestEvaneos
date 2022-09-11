@testable import DestinationGuide
import Foundation
import RxSwift
import XCTest

class FetchDestinationDetailsUseCaseTests: XCTestCase {
    var sut: FetchDestinationDetailsUseCase!
    var mockedRepository: MockDestinationsRepository!

    override func setUp() {
        mockedRepository = MockDestinationsRepository()
        sut = FetchDestinationDetailsUseCase(repository: mockedRepository)
    }

    func tests_useCase_with_data() async {
        let expectedResult: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )

        mockedRepository.getDestinationsUseCaseError = nil
        mockedRepository.getDestinationDetailsUseCaseData = expectedResult

        let expectedId = "217"
        let result = await sut.execute(destinationID: expectedId)
        XCTAssertEqual(result, .success(expectedResult))
        XCTAssertEqual(expectedId, mockedRepository.getDestinationDetailsGotCalledWith)
        XCTAssertTrue(mockedRepository.getDestinationDetailsUseCaseGotCalled)
    }

    func tests_useCase_with_error() async {
        let expectedResult: DestinationFetchingServiceError = .destinationNotFound

        mockedRepository.getDestinationsUseCaseError = expectedResult
        mockedRepository.getDestinationDetailsUseCaseData = nil

        let expectedId = "217"
        let result = await sut.execute(destinationID: expectedId)
        XCTAssertEqual(result, .failure(expectedResult))
        XCTAssertEqual(expectedId, mockedRepository.getDestinationDetailsGotCalledWith)
        XCTAssertTrue(mockedRepository.getDestinationDetailsUseCaseGotCalled)
    }

    override func tearDown() {
        super.tearDown()
        mockedRepository = nil
        sut = nil
    }
}
