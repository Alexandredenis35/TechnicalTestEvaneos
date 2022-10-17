@testable import DestinationGuide
import XCTest

final class DestinationsRepositoryTests: XCTestCase {
    var sut: DestinationsRepository!
    var mockedDataSource: MockFetchingService!

    override func setUp() {
        mockedDataSource = MockFetchingService()
        sut = DestinationsRepository(dataSource: mockedDataSource)
    }

    func tests_repository_getDestinations_with_data() async {
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
        mockedDataSource.getDestinationsData = expectedResult
        mockedDataSource.getDestinationsError = nil

        let result = await sut.getDestinations()
        XCTAssertEqual(result, .success(expectedResult))
        XCTAssertTrue(mockedDataSource.getDestinationsGotCalled)
    }

    func tests_repository_with_getDestinations_error() async {
        let expectedResult: DestinationFetchingServiceError = .destinationNotFound
        mockedDataSource.getDestinationsData = nil
        mockedDataSource.getDestinationsError = expectedResult

        let result = await sut.getDestinations()
        XCTAssertEqual(result, .failure(expectedResult))
        XCTAssertTrue(mockedDataSource.getDestinationsGotCalled)
    }

    func tests_repository_getDestinationDetails_with_data() async {
        let expectedResult: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )
        let expectedId = "217"
        mockedDataSource.getDestinationDetailsData = expectedResult
        mockedDataSource.getDestinationDetailsError = nil

        let result = await sut.getDestinationDetails(destinationID: expectedId)
        XCTAssertEqual(result, .success(expectedResult))
        XCTAssertEqual(expectedId, mockedDataSource.getDestinationDetailsGotCalledWith)
        XCTAssertTrue(mockedDataSource.getDestinationDetailsGotCalled)
    }

    func tests_repository_with_getDestinationDetails_error() async {
        let expectedResult: DestinationFetchingServiceError = .destinationNotFound
        mockedDataSource.getDestinationDetailsData = nil
        mockedDataSource.getDestinationDetailsError = expectedResult
        let expectedId = "217"

        let result = await sut.getDestinationDetails(destinationID: "217")
        XCTAssertEqual(result, .failure(expectedResult))
        XCTAssertEqual(expectedId, mockedDataSource.getDestinationDetailsGotCalledWith)
        XCTAssertTrue(mockedDataSource.getDestinationDetailsGotCalled)
    }

    func tests_repository_with_getDataRequest_with_validURL() async {
        let validUrlImage =
            URL(string: "https://static1.evcdn.net/images/reduction/1027399_w-800_h-800_q-70_m-crop.jpg")!

        let data = await sut.getDataRequest(url: validUrlImage)
        XCTAssertTrue(data != nil)
    }

    func tests_repository_with_getDataRequest_with_invalidUrl() async {
        let invalidUrlImage = URL(string: "https://")!
        let data = await sut.getDataRequest(url: invalidUrlImage)
        XCTAssertTrue(data == nil)
    }

    override func tearDown() {
        super.tearDown()
        mockedDataSource = nil
        sut = nil
    }
}
