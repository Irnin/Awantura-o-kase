import SwiftUI

struct ContentView: View {
    
    private var gameController = GameController.shared
    
    var body: some View {
        Group {
            switch gameController.getCurrentGameState() {
            case .preGame:
                PreGameView()
            case .auction:
                AuctionAdminView()
            }
        }
    }
}
