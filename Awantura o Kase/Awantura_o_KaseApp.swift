import SwiftUI

@main
struct Awantura_o_KaseApp: App {
    private let gameController = GameController.shared
    private let auctionController = AuctionController.shared
    
    var body: some Scene {
        
        WindowGroup("Host View") {
            HostView()
        }
        
        WindowGroup("TV") {
            TvView()
        }
        
        .commands {
            CommandMenu("DEBUG") {
                Menu("Game State") {
                    Button("PreGame") {
                        gameController.setCurrentGameState(.preGame)
                    }
                    
                    Button("Auction") {
                        gameController.setCurrentGameState(.auction)
                    }
                }
            }
        }
    }
}
