//
//  VoltButton.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 22/10/2023.
//

import SwiftUI

struct VoltButton: View {
    private var title: String
    private var description: String?
    private var traillingImage: Image?
    private var style: VoltButtonStyle
    private var onSelect: (() -> Void)?

    init(
        _ title: String,
        description: String? = nil,
        traillingImage: Image? = nil,
        style: VoltButtonStyle = .primaryButton,
        onSelect: (() -> Void)?
    ) {
        self.title = title
        self.description = description
        self.traillingImage = traillingImage
        self.style = style
        self.onSelect = onSelect
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.borderColor, lineWidth: 2)
                .background(style.backgroundColor)
                .frame(maxHeight: 60)

            HStack {
                VStack(alignment: .center, spacing: 4) {
                    Text(title)
                        .font(.headline)

                    if let description = description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                if let traillingImage {
                    Spacer()
                    traillingImage
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 8)
                }
            }
            .padding(.horizontal, 12)
        }
        .foregroundColor(.blue)
    }
}

#Preview {
    VoltButton(
        "Retry",
        description: "some",
        traillingImage: Image(systemName: "square.and.arrow.up.circle.fill"),
        style: .primaryButton,
        onSelect: nil
    )
}
