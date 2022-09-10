//
//  FetchDestinationDetailsUseCaseTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre DENIS on 10/09/2022.
//

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
        let expectedResult: Set<Destination> = [
        ]
        mockedRepository.getDestinationsUseCaseData = expectedResult
        sut.execute(destinationID: <#String#>) // Here Single<Destinations>
    }

    override func tearDown() {
        super.tearDown()
        mockedRepository = nil
        sut = nil
    }
}
