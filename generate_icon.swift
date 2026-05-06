#!/usr/bin/env swift
import AppKit

func createGradientImage(size: NSSize) -> NSImage {
    let image = NSImage(size: size)
    image.lockFocus()
    
    guard let context = NSGraphicsContext.current?.cgContext else { return image }
    
    // Create gradient
    let color1 = NSColor(red: 71/255, green: 77/255, blue: 197/255, alpha: 1.0)
    let color2 = NSColor(red: 22/255, green: 107/255, blue: 76/255, alpha: 1.0)
    let color3 = NSColor(red: 135/255, green: 76/255, blue: 67/255, alpha: 1.0)
    
    // Draw gradient background
    let colors = [color1, color2, color3] as CFArray
    if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0.0, 0.5, 1.0]) {
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: size.height), options: [])
    }
    
    // Draw T letter
    let tColor = NSColor.white
    let font = NSFont.systemFont(ofSize: size.height * 0.5, weight: .heavy)
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: tColor
    ]
    
    let tString = "T"
    let tSize = tString.size(withAttributes: attributes)
    let tOrigin = NSPoint(x: (size.width - tSize.width) / 2, y: (size.height - tSize.height) / 2)
    tString.draw(at: tOrigin, withAttributes: attributes)
    
    image.unlockFocus()
    return image
}

func saveImage(_ image: NSImage, path: String) {
    guard let tiffData = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [:]) else { return }
    
    try? pngData.write(to: URL(fileURLWithPath: path))
}

let sizes = [
    (40, "Icon-App-20x20@2x.png"),
    (60, "Icon-App-20x20@3x.png"),
    (58, "Icon-App-29x29@2x.png"),
    (87, "Icon-App-29x29@3x.png"),
    (80, "Icon-App-40x40@2x.png"),
    (120, "Icon-App-40x40@3x.png"),
    (120, "Icon-App-60x60@2x.png"),
    (180, "Icon-App-60x60@3x.png"),
    (1024, "Icon-App-1024x1024@1x.png")
]

let basePath = "/Users/thomas/stitch_tombudget_finance_tracker/TomBudget/Assets.xcassets/AppIcon.appiconset"

for (size, filename) in sizes {
    let image = createGradientImage(size: NSSize(width: size, height: size))
    saveImage(image, path: "\(basePath)/\(filename)")
    print("Generated \(filename)")
}

print("All icons generated!")
