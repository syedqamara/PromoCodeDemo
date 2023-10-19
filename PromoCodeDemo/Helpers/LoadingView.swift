//
//  LoadingView.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import SwiftUI
struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    @State var color: Color = .green
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: color))
                    .scaleEffect(3, anchor: .center)
            }
        }
    }
}

extension View {
    @ViewBuilder
    func loadingView(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
