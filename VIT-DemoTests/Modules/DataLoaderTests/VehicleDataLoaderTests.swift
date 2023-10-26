//
//  VehicleDataLoaderTests.swift
//  VIT-DemoTests
//
//  Created by Justinas Kristopaitis on 26/10/2023.
//

import XCTest
@testable import VIT_Demo
import VehicleAPI
import Combine

class VehicleDataLoaderTests: XCTestCase {
    var sut: VehicleDataLoader!
    var mockService: MockControlUnitService!

    override func setUp() {
        mockService = MockControlUnitService()
        sut = VehicleDataLoader(service: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
    }

    func testLoading() async throws {
        mockService.numberOfEntriesToReturn = 3
        let units = try await sut.loadData(forceLoad: false)
        XCTAssertTrue(!units.isEmpty)
    }

    func testEmptyLoading() async throws {
        let units = try await sut.loadData(forceLoad: false)
        XCTAssertTrue(units.isEmpty)
    }

    func testLoadCachedData() async throws {
        mockService.numberOfEntriesToReturn = 11
        let filledUnits = try await sut.loadData(forceLoad: true)
        XCTAssertTrue(!filledUnits.isEmpty)

        let reloadData = try await sut.loadData(forceLoad: false)
        XCTAssertEqual(filledUnits, reloadData)

    }

    func testLoadingError() async {
        mockService.shouldThrow = true

        do {
            _  = try await sut.loadData(forceLoad: true)
            XCTFail("Expected to throw error")
        } catch {
            XCTAssertTrue(error is VoltError)
        }
    }

    func testFaultCaunt() {
        let caunt = sut.faultCaunt(forId: "1")
        XCTAssertTrue(caunt == 1)
        let caunt2 = sut.faultCaunt(forId: "2")
        XCTAssert(caunt2 == 0)
    }

    func testFaultCauntWithInvalidString() {
        let caunt = sut.faultCaunt(forId: "1w")
        XCTAssertTrue(caunt == 0)
    }
}

class MockControlUnitService: ControlUnitServiceInterface {
    var numberOfEntriesToReturn: Int = 0
    var shouldThrow: Bool = false

    func controlUnits() -> Deferred<Future<[VehicleAPI.ControlUnit], Error>> {
        return Deferred { Future { _ in } }
    }
    
    func controlUnit(with id: Int) -> Deferred<Future<VehicleAPI.ControlUnit?, Never>> {
        return Deferred { Future { _ in } }
    }
    
    func controlUnits(completion: @escaping (Result<[VehicleAPI.ControlUnit], Error>) -> Void) {
    }

    func controlUnits() async throws -> [VehicleAPI.ControlUnit] {
        guard !shouldThrow else { throw VoltError.custom("error") }
        return try await mockedControlUnits(returnValues: numberOfEntriesToReturn)
    }

    func controlUnit(with id: Int) -> VehicleAPI.ControlUnit? {
        return nil
    }

    func faultCount(controlUnitId: Int) -> Deferred<Future<Int, Never>> {
        return Deferred { Future { _ in } }
    }

    func mockedControlUnits(returnValues: Int) async throws -> [ControlUnit] {
        var units: [ControlUnit] = []
        for _ in 0..<returnValues {
            units.append(
                ControlUnit(
                    id: UUID().uuidString,
                    name: UUID().uuidString,
                    status: randomStatus(),
                    protocol: randomStatus() + randomString(),
                    serialNumber: randomString(),
                    imageUrlString: randomString()
                )
            )
        }
        return units
    }

    func faultCount(controlUnitId: Int) -> Int {
        if controlUnitId == 1 {
            return 1
        } else {
            return 0
        }
    }

    private func randomStatus() -> String {
        let randomValue = arc4random_uniform(2)
        return randomValue == 0 ? "ok" : "faulty"
    }

    func randomString() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""

        for _ in 0..<10 {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomString.append(character)
        }

        return randomString
    }
}

