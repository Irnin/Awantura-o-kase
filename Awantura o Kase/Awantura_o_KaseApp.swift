import SwiftUI

@main
struct Awantura_o_KaseApp: App {
    private var gameController = GameController.shared
    
    var body: some Scene {
        
        WindowGroup("Host View") {
            AuctionHostView()
        }
        
        WindowGroup("TV") {
            ContentView()
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
