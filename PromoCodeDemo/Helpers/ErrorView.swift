//
//  ErrorView.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import Foundation
import SwiftUI

struct ErrorViewModifier<E: Error>: ViewModifier {
    @Binding var error: E?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let error = error {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                        
                        HStack {
                            Text(error.localizedDescription)
                                .foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    self.error = nil
                                }
                            }) {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(.close)
                                            .renderingMode(.template)
                                            .foregroundColor(.red)
                                            .padding(5)
                                    )
                            }
                            .padding(.trailing, 10)
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            self.error = nil
                        }
                    }
                }
            }
        }
    }
}

extension View {
    @ViewBuilder
    func errorView<E: Error>(error: Binding<E?>) -> some View {
        self.modifier(ErrorViewModifier(error: error))
    }
}

