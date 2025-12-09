import SwiftUI

struct BasicInformationsInspector: View {
    @Bindable var controller = GameController.shared
    
    var body: some View {
        Text("Basic Informations")
            .font(.title)
            .foregroundColor(.accentColor)
        
        Text(String("Current phase: \(controller.getCurrentGameState())"))
        
        Text(String("Question: \(controller.getQuestionNumber())"))
        Text(String("Category: \(controller.getCurrentCategory())"))
        
        Text(String("Blue: \(controller.getBalance(ofTeam: .blue).formatted())"))
        Text(String("Green: \(controller.getBalance(ofTeam: .green).formatted())"))
        Text(String("Yellow: \(controller.getBalance(ofTeam: .yellow).formatted())"))
        
        Divider()
    }
}
