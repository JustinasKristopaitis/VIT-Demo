//
//  ControlUnitsViewModel.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 22/10/2023.
//

import SwiftUI
import VehicleAPI

class ControlUnitsViewModel: ObservableObject {
    enum SortOption: String, CaseIterable {
        case name = "Name"
        case status = "Status"
        case id = "ID"
    }
    
    private let vehicleDataLoader: VehicleDataLoading

    @Published var isLoading: Bool = false
    @Published var isFailed: Bool = false
    @Published var data: [ControlUnitData] = []
    @Published var sortedBy: SortOption = .name

    init(
        vehicleDataLoader: VehicleDataLoading
    ) {
        self.vehicleDataLoader = vehicleDataLoader
    }

    var sortedItems: [ControlUnitData] {
        switch sortedBy {
        case .name:
            return data.sorted { $0.name < $1.name }
        case .status:
            return data.sorted { $0.status < $1.status }
        case .id:
            return data.sorted {
                if let int1 = Int($0.idString), let int2 = Int($1.idString) {
                    return int1 < int2
                }
                return $0.idString < $1.idString
            }
        }
    }

    func loadData(forceLoad: Bool) {
        Task { @MainActor in
            isLoading = true
            do {
                data = try await vehicleDataLoader.loadData(forceLoad: false)
            }
            catch {
                isFailed = true
            }
            if !data.isEmpty {
                isFailed = false
            }
            isLoading = false
        }
    }
}


