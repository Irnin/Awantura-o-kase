import SwiftUI
import AppKit
import CoreText

struct ContentView: View {
    
    private var gameController = GameController.shared
    
    var body: some View {
        ZStack {
            switch gameController.getCurrentGameState() {
            case .preGame:
                //PreGameView()
                AuctionTvView()
            case .auction:
                AuctionTvView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
