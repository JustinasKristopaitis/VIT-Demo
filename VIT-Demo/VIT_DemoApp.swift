//
//  VIT_DemoApp.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 26/10/2023.
//

import SwiftUI

@main
struct VIT_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            ControlUnitsView(viewModel: ControlUnitsViewModel(vehicleDataLoader: VehicleDataLoader()))
        }
    }
}
