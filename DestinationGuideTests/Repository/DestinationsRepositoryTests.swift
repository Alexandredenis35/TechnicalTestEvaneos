@testable import DestinationGuide
import XCTest

class DestinationsRepositoryTests: XCTestCase {
    var sut: DestinationsRepository!
    var mockedDataSource: MockFetchingService!

    override func setUp() {
        mockedDataSource = MockFetchingService()
        sut = DestinationsRepository(dataSource: mockedDataSource)
    }

    func tests_repository_with_data() async {
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
        mockedDataSource.getDestinationsData = expectedResult
        sut.getDestinations() // Here Single<Destinations>
    }

    
    override func tearDown() {
        super.tearDown()
        mockedDataSource = nil
        sut = nil
    }
    //  func tests_repository_with_not_found_error() async {
    //    let expectedResult = APIError.notFound
    //    dataSource.error = APIError.notFound
    //    let result = await sut.getStats(id: "iteakz-", platform: "psn")
    //    XCTAssertEqual(result, .failure(expectedResult))
    // }
    //
    // func tests_repository_with_status_not_Ok_error() async {
    //    let expectedResult = APIError.statusNotOk
    //    dataSource.error = APIError.statusNotOk
    //    let result = await sut.getStats(id: "iteakz-", platform: "psn")
    //    XCTAssertEqual(result, .failure(expectedResult))
    // }
    //
    // func tests_repository_with_bad_url_error() async {
    //    let expectedResult = APIError.badUrl
    //    dataSource.error = APIError.badUrl
    //    let result = await sut.getStats(id: "iteakz-", platform: "psn")
    //    XCTAssertEqual(result, .failure(expectedResult))
    // }
}
