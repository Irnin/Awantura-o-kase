import SwiftUI

struct BasicInformationsInspector: View {
    @Bindable var controller = GameController.shared
    
    var body: some View {
        Text("Basic Informations")
            .font(.title)
            .foregroundColor(.accentColor)
        
        Text(String("Current phase: \(controller.getCurrentGameState())"))
        
        Text(String("Category: \(controller.getCurrentCategory())"))
        
        Divider()
    }
}
