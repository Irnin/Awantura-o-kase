import SwiftUI


// MARK: - Główny Widok (Zmieniamy na nową logikę)
struct ReelHostView: View {
    
    @Bindable private var controller = ReelController.shared
    @Bindable private var gameController = GameController.shared
    
    var body: some View {
        VStack {
            MyHeader(header: "Draw Category")
            
            Spacer()
            
            Spinner()
            
            Spacer()
            
            HStack() {
                Button("Draw Category") {
                    startSpinning()
                }
                Button("Quick Randomize") {
                    quickSpin()
                }
                
                Button("Next stage", systemImage: "arrow.right.square.fill") {
                    gameController.jumpToAuction()
                }
            }
        }
        .padding(20)
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
