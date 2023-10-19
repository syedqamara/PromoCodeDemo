//
//  RoundedRectangleModifier.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import SwiftUI

struct RoundedRectangleModifier: ViewModifier {
    var cornerRadius: CGFloat
    var lineWidth: CGFloat
    var showShadow: Bool
    var strokeColor: Color
    var fillColor: Color

    func body(content: Content) -> some View {
        content
            .background(
                Group(content: {
                    if showShadow {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(strokeColor, lineWidth: lineWidth)
                            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(fillColor))
                            .shadow(color: .black.opacity(0.5), radius: 5, x: -1.0, y: 4.0)
                    } else {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(strokeColor, lineWidth: lineWidth)
                            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(fillColor))
                    }
                })
            )
    }
}

extension View {
    func roundedRectangle(cornerRadius: CGFloat, lineWidth: CGFloat, strokeColor: Color, fillColor: Color, showShadow: Bool = false) -> some View {
        self.modifier(RoundedRectangleModifier(cornerRadius: cornerRadius, lineWidth: lineWidth, showShadow: showShadow, strokeColor: strokeColor, fillColor: fillColor))
    }
}

