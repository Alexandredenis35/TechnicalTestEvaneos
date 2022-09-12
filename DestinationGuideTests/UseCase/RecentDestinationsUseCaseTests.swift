@testable import DestinationGuide
import Foundation
import XCTest

final class RecentDestinationsUseCaseTests: XCTestCase {
    var sut: RecentDestinationUseCase!
    var currentRecentDestinations: [DestinationDetails]!
    override func setUp() {
        currentRecentDestinations = []
    }

    func tests_useCase_with_empty_currentRecentDestinations() {
        sut = RecentDestinationUseCase(currentRecentDestinations: currentRecentDestinations)
        let destinationDetail: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )
        let recentDestinations = sut.execute(details: destinationDetail)

        XCTAssertEqual(recentDestinations, [destinationDetail])
    }

    func tests_useCase_with_complete_currentRecentDestinations() {
        let lastSearchedDestination: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )
        currentRecentDestinations = [
            .init(id: "98", name: "Australie", url: URL(string: "https://evaneos.fr/australie")!),
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!)
        ]

        sut = RecentDestinationUseCase(currentRecentDestinations: currentRecentDestinations)

        let recentDestinations = sut.execute(details: lastSearchedDestination)

        XCTAssertEqual(recentDestinations, [
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!),
            .init(id: "217", name: "Barbade", url: URL(string: "https://evaneos.fr/barbade")!)
        ])
    }

    func tests_useCase_with_same_recentDestinations_with_one_recentDestination() async {
        let lastSearchedDestination: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )
        currentRecentDestinations = [
            .init(
                id: "217",
                name: "Barbade",
                url: URL(string: "https://evaneos.fr/barbade")!
            )
        ]

        sut = RecentDestinationUseCase(currentRecentDestinations: currentRecentDestinations)
        let recentDestinations = sut.execute(details: lastSearchedDestination)
        XCTAssertEqual(recentDestinations, [
            .init(id: "217", name: "Barbade", url: URL(string: "https://evaneos.fr/barbade")!)
        ])
    }

    func tests_useCase_with_same_recentDestinations_with_two_recentDestinations() async {
        let lastSearchedDestination: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )

        currentRecentDestinations = [
            .init(
                id: "217",
                name: "Barbade",
                url: URL(string: "https://evaneos.fr/barbade")!
            ),
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!)
        ]

        sut = RecentDestinationUseCase(currentRecentDestinations: currentRecentDestinations)

        let recentDestinations = sut.execute(details: lastSearchedDestination)

        XCTAssertEqual(recentDestinations, [
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!),
            .init(id: "217", name: "Barbade", url: URL(string: "https://evaneos.fr/barbade")!)
        ])
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        currentRecentDestinations = nil
    }
}
