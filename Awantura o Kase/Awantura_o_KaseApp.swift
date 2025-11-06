import SwiftUI

@main
struct Awantura_o_KaseApp: App {
    @State private var gameController = GameController()
    
    var body: some Scene {
        WindowGroup {
            AuctionAdminView()
                .environment(gameController)
        }
    }
}
