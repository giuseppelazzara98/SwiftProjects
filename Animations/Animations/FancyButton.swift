//
//  FancyButton.swift
//  Animations
//
//  Created by Giuseppe Lazzara on 03/06/24.
//

import SwiftUI

struct FancyButton: View {
    @State private var animationAmount = 1.0
    var body: some View {
        Button("Tap Me") {
                //animationAmount += 1
        }
        .onAppear{
            animationAmount = 2
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2-animationAmount)
                .animation(
                    .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),value: animationAmount)
        )
        .animation(
            .easeInOut(duration: 0.3)
            ,
            value: animationAmount)
    }
}

#Preview {
    FancyButton()
}
