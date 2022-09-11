@testable import DestinationGuide
import Foundation
import XCTest

class RecentDestinationsUseCaseTests: XCTestCase {
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
        // .init(id: "6", name: "Allemagne", url: URL(string: "https://evaneos.fr/allemagne")!),
        // .init(id: "306", name: "Bali", url: URL(string: "https://evaneos.fr/bali")!),
        // .init(id: "13", name: "Autriche", url: URL(string: "https://evaneos.fr/autriche")!),
        // .init(id: "147", name: "Antilles", url: URL(string: "https://evaneos.fr/antilles")!),
        // .init(id: "373", name: "Basse-Californie", url: URL(string: "https://evaneos.fr/basse-californie")!),
        // .init(id: "73", name: "Afrique du Sud", url: URL(string: "https://evaneos.fr/afrique-du-sud")!),
        // .init(id: "98", name: "Australie", url: URL(string: "https://evaneos.fr/australie")!),
        // .init(id: "426", name: "Amazonie Brésilienne", url: URL(string: "https://evaneos.fr/amazonie-bresilienne")!),
        // .init(id: "377", name: "Bajio", url: URL(string: "https://evaneos.fr/bajio")!),
        // .init(id: "74", name: "Azerbaïdjan", url: URL(string: "https://evaneos.fr/azerbaidjan")!),
        // .init(id: "115", name: "Antarctique", url: URL(string: "https://evaneos.fr/antarctique")!),
        // .init(id: "110", name: "Bangladesh", url: URL(string: "https://evaneos.fr/bangladesh")!),
        // .init(id: "29", name: "Algérie", url: URL(string: "https://evaneos.fr/algerie")!),
        // .init(id: "75", name: "Argentine", url: URL(string: "https://evaneos.fr/argentine")!),
        // .init(id: "173", name: "Açores", url: URL(string: "https://evaneos.fr/acores")!),
        // .init(id: "287", name: "Angleterre", url: URL(string: "https://evaneos.fr/angleterre")!),
        // .init(id: "107", name: "Bahamas", url: URL(string: "https://evaneos.fr/bahamas")!)

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
    }
}
