import SwiftUI

struct TVInspector: View {
    @Bindable var gameController = GameController.shared
    
    var body: some View {
        HStack {
            Text("TV")
                .font(.title)
                .foregroundColor(.accentColor)
        }
        
        ForEach(TVscene.allCases, id: \.self) { tvScene in
            Button(action: { gameController.setTvScene(tvScene) }) {
                Text(tvScene.displayName)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(gameController.getTvScene() == tvScene ? .accentColor : .primary)
            }
        }
        
        Divider()
    }
}
