#!/usr/bin/env python3
"""Generate beautiful TomBudget app icon with gradient and letter T"""
from PIL import Image, ImageDraw, ImageFont
import math

def create_gradient(width, height, color1, color2, color3):
    """Create a beautiful gradient background"""
    image = Image.new('RGBA', (width, height))
    draw = ImageDraw.Draw(image)
    
    for y in range(height):
        # Create a radial gradient effect
        for x in range(width):
            # Calculate distance from corners for multi-point gradient
            dx1 = x / width
            dy1 = y / height
            
            # Blend colors based on position
            r = int(color1[0] * (1 - dx1) + color2[0] * dx1)
            g = int(color1[1] * (1 - dy1) + color3[1] * dy1)
            b = int(color2[2] * (1 - dx1) + color3[2] * dy1)
            
            draw.point((x, y), fill=(r, g, b, 255))
    
    return image

def add_glass_effect(image):
    """Add glassmorphism effect"""
    overlay = Image.new('RGBA', image.size, (255, 255, 255, 0))
    draw = ImageDraw.Draw(overlay)
    
    # Add subtle white overlay for glass effect
    for y in range(image.height):
        alpha = int(30 * (1 - y / image.height))
        draw.line([(0, y), (image.width, y)], fill=(255, 255, 255, alpha))
    
    return Image.alpha_composite(image, overlay)

def draw_t_letter(image, color):
    """Draw stylized T letter"""
    draw = ImageDraw.Draw(image)
    width, height = image.size
    
    # T parameters
    t_width = int(width * 0.6)
    t_height = int(height * 0.15)
    stem_width = int(width * 0.18)
    
    # Top bar
    top_left = ((width - t_width) // 2, int(height * 0.35))
    top_right = (top_left[0] + t_width, top_left[1] + t_height)
    draw.rounded_rectangle([top_left, top_right], radius=t_height//2, fill=color)
    
    # Stem
    stem_left = ((width - stem_width) // 2, top_left[1])
    stem_right = (stem_left[0] + stem_width, int(height * 0.65))
    draw.rounded_rectangle([stem_left, stem_right], radius=stem_width//2, fill=color)
    
    return image

def main():
    # Brand colors (RGB)
    primary = (71, 77, 197)    # #474dc5
    secondary = (22, 107, 76)    # #166b4c
    tertiary = (135, 76, 67)     # #874c43
    white = (255, 255, 255)
    
    # Generate icons in different sizes
    sizes = [
        (20*2, "Icon-App-20x20@2x.png"),
        (20*3, "Icon-App-20x20@3x.png"),
        (29*2, "Icon-App-29x29@2x.png"),
        (29*3, "Icon-App-29x29@3x.png"),
        (40*2, "Icon-App-40x40@2x.png"),
        (40*3, "Icon-App-40x40@3x.png"),
        (60*2, "Icon-App-60x60@2x.png"),
        (60*3, "Icon-App-60x60@3x.png"),
        (1024, "Icon-App-1024x1024@1x.png"),
    ]
    
    base_path = "/Users/thomas/stitch_tombudget_finance_tracker/TomBudget/Assets.xcassets/AppIcon.appiconset"
    
    for size, filename in sizes:
        # Create gradient background
        img = create_gradient(size, size, primary, secondary, tertiary)
        
        # Add glass effect
        img = add_glass_effect(img)
        
        # Draw T letter
        img = draw_t_letter(img, white)
        
        # Save
        img.save(f"{base_path}/{filename}")
        print(f"Generated {filename}")
    
    print("All icons generated successfully!")

if __name__ == "__main__":
    main()
