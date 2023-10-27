//
//  VoltButtonStyle.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 22/10/2023.
//

import SwiftUI

enum VoltButtonStyle {
    case primaryButton, warning

    var titleColor: Color {
        switch self {
        case .primaryButton:
            return .green
        case .warning:
            return .red
        }
    }

    var descriptionColor: Color {
        switch self {
        case .primaryButton:
            return .blue
        case .warning:
            return .black
        }
    }

    var borderColor: Color {
        switch self {
        case .primaryButton:
            return .green
        case .warning:
            return .red
        }
    }

    var backgroundColor: Color {
        switch self {
        case .primaryButton:
            return .green.opacity(0.15)
        case .warning:
            return .red.opacity(0.1)
        }
    }
}
