//
//  ControlUnitData.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 26/10/2023.
//

import Foundation

struct ControlUnitData: Identifiable, Equatable {
    var id: String { idString }
    let idString: String
    let name: String
    let status: String
    let `protocol`: String?
    let serialNumber: String
    let imageUrl: String
}
