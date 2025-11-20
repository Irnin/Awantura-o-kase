import SwiftUI

struct BlinkingDot: View {
    var isActive: Bool
    var size: CGFloat = 14

    @State private var animate = false

    var body: some View {
        Circle()
            .fill(isActive ? Color.red : Color(red: 0.5, green: 0, blue: 0))
            .frame(width: size, height: size)
            .scaleEffect(isActive ? 1.3 : 1.0)
            .opacity(isActive && animate ? 0.25 : 1.0)
            .onAppear {
                if isActive {
                    startBlinking()
                }
            }
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    startBlinking()
                } else {
                    stopBlinking()
                }
            }
    }

    private func startBlinking() {
        withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
            animate = true
        }
    }

    private func stopBlinking() {
        withAnimation(.easeOut(duration: 0.2)) {
            animate = false
        }
    }
}
