//
//  ControlUnitDetailsViewModelTests.swift
//  VIT-DemoTests
//
//  Created by Justinas Kristopaitis on 26/10/2023.
//

@testable import VIT_Demo
import XCTest

class ControlUnitDetailsViewModelTests: XCTestCase {
    var sut: ControlUnitsDetailsViewModel!
    var service: MockVehicleDataLoader!

    override func setUp() {
        super.setUp()
        service = MockVehicleDataLoader()
        sut = ControlUnitsDetailsViewModel(
            vehicleDataLoading: service,
            controlUnit: ControlUnitData(
                idString: "1",
                name: "Name",
                status: "ok",
                protocol: "1",
                serialNumber: "123",
                imageUrl: ""
            )
        )
    }

    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }

    func testInit() {
        sut.getFaultCount()
        XCTAssertTrue(sut.faultCaunt == 0)

        let service = MockVehicleDataLoader()
        service.faultCaunt = 5
        sut = ControlUnitsDetailsViewModel(vehicleDataLoading: service, controlUnit: ControlUnitData(idString: "", name: "", status: "", protocol: "", serialNumber: "", imageUrl: ""))
        sut.getFaultCount()
        let exp = expectation(description: "Loading faults")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.sut.faultCaunt, 5)
            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
