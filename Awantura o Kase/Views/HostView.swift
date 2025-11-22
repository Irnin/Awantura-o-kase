import SwiftUI

struct HostView: View {
    @State var showInspector = true
    
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
            
            VARHostView()
                .tabItem {
                    Label("VAR", systemImage: "camera.fill")
                }
        }
        .tabViewStyle(.sidebarAdaptable)
        .inspector(isPresented: $showInspector) {
            Inspector()
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    showInspector.toggle()
                } label: {
                    Label("Inspector", systemImage: "sidebar.trailing")
                }
            }
        }
    }
}
