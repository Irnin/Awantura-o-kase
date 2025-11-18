import SwiftUI

struct HostView: View {
    var body: some View {
        TabView {
            PreGameView()
                .tabItem {
                    Label("Waiting", systemImage: "clock.fill")
                }
            
            AuctionHostView()
                .tabItem {
                    Label("Auction", systemImage: "hammer.fill")
                }
        }
    }
}
