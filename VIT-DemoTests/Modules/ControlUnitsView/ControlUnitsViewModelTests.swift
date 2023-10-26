//
//  ControlUnitsViewModelTests.swift
//  VIT-DemoTests
//
//  Created by Justinas Kristopaitis on 26/10/2023.
//

@testable import VIT_Demo
import XCTest

class ControlUnitsViewModelTests: XCTestCase {
    var sut: ControlUnitsViewModel!
    var service: MockVehicleDataLoader!

    override func setUp() {
        super.setUp()

        service = MockVehicleDataLoader()
        sut = ControlUnitsViewModel(vehicleDataLoader: service)
    }

    override func tearDown() {
        service = nil
        sut = nil

        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(sut.sortedBy, .name)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.isFailed)
        XCTAssertTrue(sut.data.isEmpty)
    }

    func testSorting() {
        sut.data = mockedData
        XCTAssertEqual(sut.sortedItems.map(\.name), ["aaa", "bbb", "ccc"])
        
        sut.sortedBy = .status
        XCTAssertEqual(sut.sortedItems.map(\.status), ["faulty", "ok", "ok"])

        sut.sortedBy = .id
        XCTAssertEqual(sut.sortedItems.map(\.id), ["1", "2", "3"])
    }

    func testLoadSuccess() {
        sut.data = mockedData

        let expectation = expectation(description: "Loading expectation")

        sut.loadData(forceLoad: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertFalse(self.sut.isFailed)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testLoadFailed() {
        service.shouldThrowError = true
        sut.loadData(forceLoad: true)
        let expectation = expectation(description: "Loading failed expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertTrue(self.sut.isFailed)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    private var mockedData: [ControlUnitData] = [
        ControlUnitData(idString: "3", name: "ccc", status: "ok", protocol: nil, serialNumber: "123", imageUrl: ""),
        ControlUnitData(idString: "2", name: "bbb", status: "faulty", protocol: nil, serialNumber: "123", imageUrl: ""),
        ControlUnitData(idString: "1", name: "aaa", status: "ok", protocol: nil, serialNumber: "123", imageUrl: "")
    ]
}

class MockVehicleDataLoader: VehicleDataLoading {
    var data: [ControlUnitData] = []
    var shouldThrowError = false
    var faultCaunt: Int = 0

    func loadData(forceLoad: Bool) async throws -> [ControlUnitData] {
        if shouldThrowError {
            throw VoltError.custom("Sample error")
        }
        return data
    }

    func faultCaunt(forId id: String) -> Int {
        return faultCaunt
    }
}
