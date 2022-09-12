@testable import DestinationGuide
import Foundation
import XCTest

final class RecentDestinationsUseCaseTests: XCTestCase {
    var sut: RecentDestinationUseCase!
    override func setUp() {
        sut = RecentDestinationUseCase()
    }

    func tests_useCase_with_empty_currentRecentDestinations() {
        let currentRecentDestinations: [DestinationDetails] = []
        let destinationDetail: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )
        let recentDestinations = sut.execute(
            newRecentDestinations: destinationDetail,
            currentRecentDestinations: currentRecentDestinations
        )

        XCTAssertEqual(recentDestinations, [destinationDetail])
    }

    func tests_useCase_with_complete_currentRecentDestinations() {
        let currentRecentDestinations: [DestinationDetails] = [
            .init(id: "98", name: "Australie", url: URL(string: "https://evaneos.fr/australie")!),
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!)
        ]

        let destinationDetail: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )

        let recentDestinations = sut.execute(
            newRecentDestinations: destinationDetail,
            currentRecentDestinations: currentRecentDestinations
        )

        XCTAssertEqual(recentDestinations, [
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!),
            .init(id: "217", name: "Barbade", url: URL(string: "https://evaneos.fr/barbade")!)
        ])
    }

    func tests_useCase_with_same_recentDestinations_with_one_recentDestination() async {
        let currentRecentDestinations: [DestinationDetails] = [
            .init(
                id: "217",
                name: "Barbade",
                url: URL(string: "https://evaneos.fr/barbade")!
            )
        ]

        let destinationDetail: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )

        let recentDestinations = sut.execute(
            newRecentDestinations: destinationDetail,
            currentRecentDestinations: currentRecentDestinations
        )
        XCTAssertEqual(recentDestinations, [
            .init(id: "217", name: "Barbade", url: URL(string: "https://evaneos.fr/barbade")!)
        ])
    }

    func tests_useCase_with_same_recentDestinations_with_two_recentDestinations() async {
        let currentRecentDestinations: [DestinationDetails] = [
            .init(
                id: "217",
                name: "Barbade",
                url: URL(string: "https://evaneos.fr/barbade")!
            ),
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!)
        ]
        let destinationDetail: DestinationDetails = .init(
            id: "217",
            name: "Barbade",
            url: URL(string: "https://evaneos.fr/barbade")!
        )

        let recentDestinations = sut.execute(
            newRecentDestinations: destinationDetail,
            currentRecentDestinations: currentRecentDestinations
        )

        XCTAssertEqual(recentDestinations, [
            .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!),
            .init(id: "217", name: "Barbade", url: URL(string: "https://evaneos.fr/barbade")!)
        ])
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}
