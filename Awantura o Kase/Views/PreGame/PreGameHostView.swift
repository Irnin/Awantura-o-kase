import SwiftUI
import PoweredTouchBar

struct PreGameHostView: View {
    @Bindable private var gameController = GameController.shared
    
    var body: some View {
        
        ZStack {
            Image("aok")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Button("Next stage", systemImage: "arrow.right.square.fill") {
                gameController.startGame()
            }
        }
        
    }
}
