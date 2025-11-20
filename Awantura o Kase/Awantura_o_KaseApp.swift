import SwiftUI

@main
struct Awantura_o_KaseApp: App {
    private var gameController = GameController.shared
    private var obsController = OBSController.shared
    
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
