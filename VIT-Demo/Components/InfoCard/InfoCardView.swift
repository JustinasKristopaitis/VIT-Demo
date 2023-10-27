//
//  InfoCardView.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 25/10/2023.
//

import SwiftUI

struct InfoCardView: View {
    private var title: String
    private var description: String

    init(
        title: String,
        description: String
    ) {
        self.title = title
        self.description = description
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10, corners: [.topLeft, .topRight])

            VoltText(description, style: .small)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.blue.opacity(0.2))
                .border(Color.black.opacity(0.2), width: 1)
                .cornerRadius(0, corners: [.bottomLeft, .bottomRight])
        }
    }
}

#Preview {
    InfoCardView(
        title: "Hello world",
        description: "His car coughed, spluttered, and finally gave up. Now, he's the proud captain of the world's slowest Fast and Furious movie - Stalled and Spurious"
    )
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCornersShape(radius: radius, corners: corners)
        )
    }
}

struct RoundedCornersShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topLeft = corners.contains(.topLeft)
        let topRight = corners.contains(.topRight)
        let bottomLeft = corners.contains(.bottomLeft)
        let bottomRight = corners.contains(.bottomRight)

        let width = rect.size.width
        let height = rect.size.height

        path.move(to: CGPoint(x: width / 2, y: 0))

        if topRight {
            path.addLine(to: CGPoint(x: width - radius, y: 0))
            path.addArc(
                center: CGPoint(x: width - radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: width, y: 0))
        }

        if bottomRight {
            path.addLine(to: CGPoint(x: width, y: height - radius))
            path.addArc(
                center: CGPoint(x: width - radius, y: height - radius),
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: width, y: height))
        }

        if bottomLeft {
            path.addLine(to: CGPoint(x: radius, y: height))
            path.addArc(
                center: CGPoint(x: radius, y: height - radius),
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: 0, y: height))
        }

        if topLeft {
            path.addLine(to: CGPoint(x: 0, y: radius))
            path.addArc(
                center: CGPoint(x: radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: 0, y: 0))
        }

        return path
    }
}
