//
//  ErrorView.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 22/10/2023.
//

import SwiftUI

struct ErrorView: View {
    private var title: String
    private var message: String
    private var action: (() -> Void)?

    init(
        title: String = "Failed",
        message: String = "Someting failled. Please try again",
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.action = action
    }

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "exclamationmark.warninglight.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
            VoltText(title, style: .warning)
            VoltText(message, style: .medium)

            VoltButton("Retry", style: .warning) {
                // TBD: add reload func
                print("")
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ErrorView()
}
