import SwiftUI

struct TvView: View {
    
    private var gameController = GameController.shared
    
    var body: some View {
        ZStack {
            switch gameController.getCurrentGameState() {
            case .preGame:
                PreGameView()
            case .auction:
                AuctionTvView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
