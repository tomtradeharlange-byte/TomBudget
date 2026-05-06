import SwiftUI

extension Color {
    // Primary
    static let tombudgetPrimary = Color(hex: "#474dc5")
    static let tombudgetOnPrimary = Color(hex: "#ffffff")
    static let tombudgetPrimaryContainer = Color(hex: "#6067df")
    static let tombudgetOnPrimaryContainer = Color(hex: "#fffbff")
    
    // Secondary
    static let tombudgetSecondary = Color(hex: "#166b4c")
    static let tombudgetOnSecondary = Color(hex: "#ffffff")
    static let tombudgetSecondaryContainer = Color(hex: "#a1f0c9")
    static let tombudgetOnSecondaryContainer = Color(hex: "#1d7050")
    
    // Tertiary
    static let tombudgetTertiary = Color(hex: "#874c43")
    static let tombudgetOnTertiary = Color(hex: "#ffffff")
    static let tombudgetTertiaryContainer = Color(hex: "#a3645a")
    static let tombudgetOnTertiaryContainer = Color(hex: "#fffbff")
    
    // Surface
    static let tombudgetBackground = Color(hex: "#fcf8fb")
    static let tombudgetOnBackground = Color(hex: "#1b1b1d")
    static let tombudgetSurface = Color(hex: "#fcf8fb")
    static let tombudgetOnSurface = Color(hex: "#1b1b1d")
    static let tombudgetOnSurfaceVariant = Color(hex: "#464653")
    static let tombudgetSurfaceVariant = Color(hex: "#e4e2e4")
    static let tombudgetSurfaceContainerLowest = Color(hex: "#ffffff")
    static let tombudgetSurfaceContainerLow = Color(hex: "#f6f3f5")
    static let tombudgetSurfaceContainer = Color(hex: "#f0edef")
    static let tombudgetSurfaceContainerHigh = Color(hex: "#eae7ea")
    static let tombudgetSurfaceContainerHighest = Color(hex: "#e4e2e4")
    
    // Error
    static let tombudgetError = Color(hex: "#ba1a1a")
    static let tombudgetOnError = Color(hex: "#ffffff")
    static let tombudgetErrorContainer = Color(hex: "#ffdad6")
    static let tombudgetOnErrorContainer = Color(hex: "#93000a")
    
    // Outline
    static let tombudgetOutline = Color(hex: "#767685")
    static let tombudgetOutlineVariant = Color(hex: "#c6c5d6")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
