import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.tombudgetSurfaceContainerLowest.opacity(0.8))
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .blur(radius: 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}

struct GlassCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.tombudgetSurfaceContainerLowest.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard() -> some View {
        self.modifier(GlassCardStyle())
    }
}
