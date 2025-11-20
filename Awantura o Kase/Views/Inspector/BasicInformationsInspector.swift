import SwiftUI

struct BasicInformationsInspector: View {
    @Bindable var gameController = GameController.shared
    
    var body: some View {
        Text("Basic Informations")
            .font(.title)
            .foregroundColor(.accentColor)
        
        Text(String("Current phase: \(gameController.getCurrentGameState())"))
        
        Divider()
    }
}
