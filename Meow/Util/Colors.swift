//
//  Colors.swift
//  Meow
//
//  Created by phrygian on 2024/9/26.
//

import Foundation
import SwiftUI


extension Color {
    init(hex: String) {
        let r, g, b: Double

        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        let scanner = Scanner(string: hexSanitized)
        if hexSanitized.count == 6 {
            // RGB (RRGGBB)
            var rgb: UInt64 = 0
            scanner.scanHexInt64(&rgb)
            r = Double((rgb >> 16) & 0xFF) / 255
            g = Double((rgb >> 8) & 0xFF) / 255
            b = Double(rgb & 0xFF) / 255
        } else if hexSanitized.count == 8 {
            // ARGB (AARRGGBB)
            var argb: UInt64 = 0
            scanner.scanHexInt64(&argb)
            r = Double((argb >> 16) & 0xFF) / 255
            g = Double((argb >> 8) & 0xFF) / 255
            b = Double(argb & 0xFF) / 255
        } else {
            // Default to black if the format is incorrect
            r = 0
            g = 0
            b = 0
        }

        self.init(red: r, green: g, blue: b)
    }
}
