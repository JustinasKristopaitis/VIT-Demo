//
//  ControlUnitDetailsViewModel.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 26/10/2023.
//

import Foundation

class ControlUnitsDetailsViewModel: ObservableObject {
    @Published var faultCaunt: Int = 0
    
    private let vehicleDataLoading: VehicleDataLoading
    let controlUnit: ControlUnitData

    init(
        vehicleDataLoading: VehicleDataLoading,
        controlUnit: ControlUnitData
    ) {
        self.vehicleDataLoading = vehicleDataLoading
        self.controlUnit = controlUnit
    }

    func getFaultCount() {
        Task { @MainActor in
            faultCaunt = vehicleDataLoading.faultCaunt(forId: controlUnit.id)
        }
    }
}
