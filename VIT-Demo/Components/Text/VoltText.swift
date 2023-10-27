//
//  VoltText.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 22/10/2023.
//

import SwiftUI

struct VoltText: View {
    let text: String
    let style: TextStyle
    let alignment: Alignment
    let customColor: Color?


    init(_ text: String, style: TextStyle, alignment: Alignment = .center, customColor: Color? = nil) {
        self.text = text
        self.style = style
        self.customColor = customColor
        self.alignment = alignment
    }

    var body: some View {
        Text(text)
            .font(style.style)
            .foregroundStyle(customColor ?? style.color)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

enum TextStyle {
    case small, medium, header, warning, custom(Color, Font)

    var style: Font {
        switch self {
        case .small:
            return .subheadline
        case .medium:
            return .headline
        case .header:
            return .largeTitle
        case .warning:
            return .title3
        case .custom(_, let font):
            return font
        }
    }

    var color: Color {
        switch self {
        case .small:
            return .brown
        case .medium:
            return .blue
        case .header:
            return .black
        case .warning:
            return .red
        case .custom(let color, _):
            return color
        }
    }
}

#Preview {
    VStack {
        VoltText("Header", style: .header)
        VoltText("Warning", style: .warning)
        VoltText("Medium", style: .medium)
        VoltText("Small", style: .small)
    }
}
