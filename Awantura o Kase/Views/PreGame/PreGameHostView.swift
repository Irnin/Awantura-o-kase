import SwiftUI
import PoweredTouchBar

struct PreGameHostView: View {
    @Bindable private var gameController = GameController.shared
    
    var body: some View {
        
        ZStack {
            Image("aok")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack {
                Spacer()
                
                Button{
                    gameController.startGame()
                } label: {

                    Label("Start Game", systemImage: "arrow.right.square.fill")
                        .font(.title2)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            
            
        }
        
    }
}
