import SwiftUI

struct TVInspector: View {
    @Bindable var gameController = GameController.shared
    
    var body: some View {
        HStack {
            Text("TV")
                .font(.title)
                .foregroundColor(.accentColor)
        }
        
        Button(action: {gameController.setTvScene(.preGame)}) {
            Text("PreGame")
                .frame(maxWidth: .infinity)
                .foregroundColor(gameController.getTvScene() == .preGame ? .accentColor : .primary)
        }
        
        Button(action: {gameController.setTvScene(.auction)}) {
            Text("Auction")
                .frame(maxWidth: .infinity)
                .foregroundColor(gameController.getTvScene() == .auction ? .accentColor : .primary)
        }
        
        Button(action: {gameController.setTvScene(.ads)}) {
            Text("Ads")
                .frame(maxWidth: .infinity)
                .foregroundColor(gameController.getTvScene() == .ads ? .accentColor : .primary)
        }
        
        Divider()
    }
}
