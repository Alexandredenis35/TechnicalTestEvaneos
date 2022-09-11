@testable import DestinationGuide
import Foundation
import XCTest

final class DestinationModelTests: XCTestCase {
    var destination: Destination!

    override func setUp() {
        super.setUp()
        destination = .init(
            id: "287",
            name: "Angleterre",
            picture: URL(string: "https://static1.evcdn.net/images/reduction/609757_w-800_h-800_q-70_m-crop.jpg")!,
            tag: "Incontournable",
            rating: 4
        )
    }

    func testUserStatsModelIdProperty() {
        XCTAssertEqual(destination.id, "287")
        XCTAssertEqual(destination.name, "Angleterre")
        XCTAssertEqual(
            destination.picture,
            URL(string: "https://static1.evcdn.net/images/reduction/609757_w-800_h-800_q-70_m-crop.jpg")
        )
        XCTAssertEqual(destination.tag, "Incontournable")
        XCTAssertEqual(destination.rating, 4)
    }

    override func tearDown() {
        super.tearDown()
        destination = nil
    }
}
