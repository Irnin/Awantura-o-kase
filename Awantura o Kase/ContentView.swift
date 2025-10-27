import SwiftUI

struct ContentView: View {
    @State private var selectedTeam = ""
    @State private var isTouchBarVisible = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Licytacja")
                .font(.largeTitle)
                .padding()
            
            Text("Wybrana drużyna: \(selectedTeam)")
                .font(.title2)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            
            Spacer()
        }
        .padding()
        .frame(minWidth: 400, minHeight: 300)
        .onAppear {
            setupTouchBar()
            showTouchBar()
        }
        .onDisappear {
            hideTouchBar()
        }
    }
    
    private func setupTouchBar() {
        NSLog("Setting up Touch Bar...")
        TouchBarController.shared.setupTouchBar()
        
        TouchBarController.shared.onButtonTapped = { team in
            DispatchQueue.main.async {
                self.selectedTeam = team
                self.animateTeamSelection(team)
            }
            NSLog("Selected team: \(team)")
        }
    }
    
    private func showTouchBar() {
        NSLog("Showing Touch Bar...")
        TouchBarController.shared.showTouchBar()
        isTouchBarVisible = true
        
        // Force refresh
        if let window = NSApplication.shared.windows.first {
            window.touchBar = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                TouchBarController.shared.showTouchBar()
            }
        }
    }
    
    private func hideTouchBar() {
        NSLog("Hiding Touch Bar...")
        TouchBarController.shared.hideTouchBar()
        isTouchBarVisible = false
    }
    
    private func animateTeamSelection(_ team: String) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
        }
    }
}
