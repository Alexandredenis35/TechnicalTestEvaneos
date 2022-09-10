@testable import DestinationGuide
import RxCocoa
import RxSwift
import XCTest

class DestinationsRepositoryTests: XCTestCase {
    var sut: DestinationsRepository!
    var mockedDataSource: MockFetchingService!
    var testExpectation: XCTestExpectation!

    override func setUp() {
        testExpectation = expectation(description: "Waiting for the getDestinations method to complete.")
        mockedDataSource = MockFetchingService()
        sut = DestinationsRepository(dataSource: mockedDataSource)
    }

    func tests_repository_with_data() async {
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

        var tripDestinations: [Destination] = []
        sut.getDestinations()
            .subscribe { [weak self] result in
                switch result {
                case let .success(destinations):
                    tripDestinations = destinations
                    self?.testExpectation.fulfill()
                case let .failure(error):
                    XCTFail("Expected success, but failed \(error)")
                }
            }
            .disposed(by: DisposeBag())

        // Wait for expectations for a maximum of 2 seconds.
        wait(for: [testExpectation], timeout: 2.0)
        XCTAssertEqual(tripDestinations, Array(expectedResult))
        XCTAssertTrue(mockedDataSource.getDestinationsGotCalled)
    }

    func tests_repository_with_error() async {
        let expectedResult: DestinationFetchingServiceError = .destinationNotFound
        mockedDataSource.getDestinationsData = nil
        mockedDataSource.getDestinationsError = .destinationNotFound
        var destinationError: Error?
        sut.getDestinations()
            .subscribe { [weak self] result in
                switch result {
                case .success:
                    XCTFail("Expected failure, but success")
                case let .failure(error):
                    destinationError = error
                    self?.testExpectation.fulfill()
                }
            }
            .disposed(by: DisposeBag())

        // Wait for expectations for a maximum of 2 seconds.
        wait(for: [testExpectation], timeout: 2.0)
        XCTAssertEqual(destinationError?.convertToDestinationError(), expectedResult)
        XCTAssertTrue(mockedDataSource.getDestinationsGotCalled)
    }

    override func tearDown() {
        super.tearDown()
        mockedDataSource = nil
        testExpectation = nil
        sut = nil
    }
}

extension Error {
    func convertToDestinationError() -> DestinationFetchingServiceError? {
        guard let error = self as? DestinationFetchingServiceError else {
            return nil
        }
        return error
    }
}
