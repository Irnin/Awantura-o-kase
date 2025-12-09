import SwiftUI

struct IbiszView: View {
    @State var showInspector = true
    @Bindable private var controller = GameController.shared
    
    var body: some View {
        TabView(selection: $controller.hostScene) {
            PreGameHostView()
                .tabItem {
                    Label("Waiting", systemImage: "clock.fill")
                }
                .tag(HostScene.preGame)
            
            ReelHostView()
                .tabItem {
                    Label("Spinner", systemImage: "inset.filled.topthird.middlethird.bottomthird.rectangle")
                }
                .tag(HostScene.drawCategory)
            
            AuctionHostView()
                .tabItem {
                    Label("Auction", systemImage: "hammer.fill")
                }
                .tag(HostScene.auction)
            
            QuestionHostView()
                .tabItem {
                    Label("Question", systemImage: "clock.badge.questionmark.fill")
                }
                .tag(HostScene.question)
            
            AdPlayerHostView()
                .tabItem{
                    Label("Ads", systemImage: "dollarsign")
                }
                .tag(HostScene.ads)
            
            QuestionWorkbench()
                .tabItem {
                    Label("Question workbench", systemImage: "questionmark.text.page.fill")
                }
                .tag(HostScene.questionWorkbench)
            
            VARHostView()
                .tabItem {
                    Label("VAR", systemImage: "camera.fill")
                }
                .tag(HostScene.varReplay)
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
