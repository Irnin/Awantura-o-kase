import SwiftUI


// MARK: - Główny Widok (Zmieniamy na nową logikę)
struct ReelHostView: View {
    
    @Bindable private var controller = ReelController.shared
    
    var body: some View {
        VStack {
            Spinner()
            
            Spacer()
            HStack() {
                Button("Draw Category") {
                    startSpinning()
                }
                Button("Quick Randomize") {
                    quickSpin()
                }
            }
            
            Spacer()
        }
    }
    
    func startSpinning() {
        controller.selectedCategory = nil
        controller.isSpinning = true
        controller.playSound()
    }
    
    func quickSpin() {
        controller.resetWinningIndex()
        controller.getWinningIndex()
    }
}

#Preview {
    Spinner()
}
