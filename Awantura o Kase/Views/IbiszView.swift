import SwiftUI

struct IbiszView: View {
    @State var showInspector = true
    
    var body: some View {
        TabView {
            PreGameView()
                .tabItem {
                    Label("Waiting", systemImage: "clock.fill")
                }
            
            ReelHostView()
                .tabItem {
                    Label("Spinner", systemImage: "inset.filled.topthird.middlethird.bottomthird.rectangle")
                }
            
            AuctionHostView()
                .tabItem {
                    Label("Auction", systemImage: "hammer.fill")
                }
            
            QuestionHostView()
                .tabItem {
                    Label("Question", systemImage: "clock.badge.questionmark.fill")
                }
            
            QuestionWorkbench()
                .tabItem {
                    Label("Question workbench", systemImage: "questionmark.text.page.fill")
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
