//
//  LoadingView.swift
//  VIT-Demo
//
//  Created by Justinas Kristopaitis on 25/10/2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: isLoading ? 1 : 0)
                .stroke(Color.blue, lineWidth: 3)
                .frame(width: 75, height: 75)
                .rotationEffect(.degrees(isLoading ? 360 : -360))
                .onAppear() {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                        self.isLoading = true
                    }
                }

            Text("Loading...")
                .font(.footnote)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    LoadingView()
}
