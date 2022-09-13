//
//  FetchDataRequestUseCaseTests.swift
//  DestinationGuideTests
//
//  Created by Alexandre DENIS on 13/09/2022.
//
@testable import DestinationGuide
import Foundation
import XCTest

final class FetchDataRequestUseCaseTests: XCTestCase {
    var sut: FetchDataRequestUseCase!
    var mockedRepository: MockDestinationsRepository!
    override func setUp() {
        mockedRepository = MockDestinationsRepository()
        sut = FetchDataRequestUseCase(repository: mockedRepository)
    }

    func tests_useCase_with_Data() async {
        let urlString = "https://static1.evcdn.net/images/reduction/39034_w-800_h-800_q-70_m-crop.jpg"
        mockedRepository.getDataRequestData = urlString.data(using: .utf8)
        let data = await sut.execute(url: URL(string: urlString)!)
        XCTAssertEqual(data, mockedRepository.getDataRequestData)
        XCTAssertEqual(mockedRepository.getDataRequestGotCalledWith, urlString)
    }

    func tests_useCase_with_NilData() async {
        let urlString = "https://static1.evcdn.net/images/reduction/39034_w-800_h-800_q-70_m-crop.jpg"
        mockedRepository.getDataRequestData = nil
        let data = await sut.execute(url: URL(string: urlString)!)
        XCTAssertEqual(data, mockedRepository.getDataRequestData)
        XCTAssertEqual(mockedRepository.getDataRequestGotCalledWith, urlString)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockedRepository = nil
    }
}
