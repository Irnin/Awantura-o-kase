import SwiftUI


// MARK: - Główny Widok (Zmieniamy na nową logikę)
struct ReelHostView: View {
    
    @Bindable private var controller = ReelController.shared
    
    var body: some View {
        VStack {
            Spinner()
            
            Spacer()
            Button("Draw Category") {
                startSpinning()
            }
            Spacer()
        }
    }
    
    func startSpinning() {
        controller.selectedCategory = nil
        controller.isSpinning = true
        controller.playSound()
    }
}

#Preview {
    Spinner()
}
