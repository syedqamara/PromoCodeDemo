//
//  Assets.swift
//  Stocks
//
//  Created by Apple on 17/10/2023.
//

import Foundation
import SwiftUI

public struct Assets {
    public enum Image: String {
        case lock = "lock_icon"
        case unlock = "unlock_icon"
        case close = "close_icon"
    }
    public enum Color: String {
        case lock = "lock_color"
        case unlock = "unlock_color"
    }
}

extension Image {
    init(_ image: Assets.Image) {
        self.init(image.rawValue)
    }
}

extension Assets.Image {
    var color: Color {
        switch self {
        case .lock:
            return .red
        case .unlock:
            return .green
        case .close:
            return .red
        }
    }
}

extension Color {
    public init(_ color: Assets.Color) {
        self.init(color.rawValue)
    }
    public init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
