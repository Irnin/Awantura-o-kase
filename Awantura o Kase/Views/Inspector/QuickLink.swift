import SwiftUI

struct QuickLink: View {
    @Bindable var controller = GameController.shared
    
    var body: some View {
        Text("Quick links")
            .font(.title)
            .foregroundColor(.accentColor)
        
        Button("Back to current phase") {
            controller.backToCurrentPhase()
        }
        
        Button("Play Ads") {
            controller.playAds()
        }
        
        Divider()
    }
}
