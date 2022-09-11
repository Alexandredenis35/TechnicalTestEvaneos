@testable import DestinationGuide
import Foundation
import XCTest

class DestinationsViewModelTests: XCTestCase {
    var sut: DestinationsViewModel!
    var mockedFetchDestinationsUseCase: MockFetchDestinationUseCase!
    var mockedFetchDestinationDetailsUseCase: MockFetchDestinationDetailsUseCase!
    var dummyCoordinator: Coordinator!

    override func setUp() {
        super.setUp()
        mockedFetchDestinationsUseCase = MockFetchDestinationUseCase()
        mockedFetchDestinationDetailsUseCase = MockFetchDestinationDetailsUseCase()
        dummyCoordinator = DummyCoordinator()
        sut = DestinationsViewModel(
            destinationsUseCase: mockedFetchDestinationsUseCase,
            destinationDetailsUseCase: mockedFetchDestinationDetailsUseCase,
            coordinator: AppCoordinator(navigationController: UINavigationController())
        )
    }

    func test_fetchDestinations_return_with_data() async {
        let expectedResult: Set<Destination> = [.init(
            id: "287",
            name: "Angleterre",
            picture: URL(string: "https://static1.evcdn.net/images/reduction/609757_w-800_h-800_q-70_m-crop.jpg")!,
            tag: "Incontournable",
            rating: 4
        )]
        mockedFetchDestinationsUseCase.executeResult = .success(expectedResult)
        await sut.fetchDestinations()
        Thread.sleep(forTimeInterval: 0.1)
        XCTAssertEqual(sut.destinationsRelay.value, Array(expectedResult))
    }

    func test_fetchDestinations_return_with_error() async {
        let expectedResult: DestinationFetchingServiceError = .destinationNotFound
        mockedFetchDestinationsUseCase.executeResult = .failure(expectedResult)
        await sut.fetchDestinations()
        Thread.sleep(forTimeInterval: 0.1)
        XCTAssertEqual(sut.destinationsRelay.value, [])
    }

    func test_fetchDestinationDetails_return_with_data() async {
        let expectedResult: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )
        mockedFetchDestinationDetailsUseCase.executeResult = .success(expectedResult)
        let expectedId = "217"
        await sut.fetchDestinationDetails(id: expectedId)
        XCTAssertEqual(sut.recentDestinationsRelay.value, [expectedResult])
        XCTAssertEqual(mockedFetchDestinationDetailsUseCase.executeGotCalledWith, expectedId)
    }

    func test_addRecentDestinations() {
        // sut.
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockedFetchDestinationsUseCase = nil
        mockedFetchDestinationDetailsUseCase = nil
        dummyCoordinator = nil
    }
}

final class MockFetchDestinationUseCase: FetchDestinationsUseCaseProtocol {
    var executeResult: Result<Set<Destination>, DestinationFetchingServiceError>?

    func execute() async -> Result<Set<Destination>, DestinationFetchingServiceError> {
        guard let executeResult = executeResult else {
            return .failure(.destinationNotFound)
        }
        return executeResult
    }
}

final class MockFetchDestinationDetailsUseCase: FetchDestinationDetailsUseCaseProtocol {
    var executeResult: Result<DestinationDetails, DestinationFetchingServiceError>?
    var executeGotCalledWith: String?

    func execute(destinationID: String) async -> Result<DestinationDetails, DestinationFetchingServiceError> {
        executeGotCalledWith = destinationID
        guard let executeResult = executeResult else {
            return .failure(.destinationNotFound)
        }
        return executeResult
    }
}

final class DummyCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = .init()

    func start() {}
}
