import SwiftUI

struct VARInspector: View {
    @Bindable var gameController = GameController.shared
    private var obsController = OBSController.shared
    
    var body: some View {
        HStack {
            Text("VAR")
                .font(.title)
                .foregroundColor(.accentColor)
            
            Spacer()
            BlinkingDot(isActive: gameController.getStateOfVarRecording())
        }
        
        if(gameController.getStateOfVarRecording()) {
            
            HStack {
                Button(action: {
                    Task {await obsController.stopReplyBuffer()}
                }) {
                    Text("STOP VAR")
                        .frame(maxWidth: .infinity)
                }
                
                Button(action: {
                    Task {await obsController.saveReplyBuffer()}
                    gameController.setTvScene(.varReplay)
                    gameController.setHostScene(.varReplay)
                }) {
                    Text("CHECK VAR")
                        .frame(maxWidth: .infinity)
                }
            }
        } else {
            Button(action: {
                Task {await obsController.startReplyBuffer()}
            }) {
                Text("Start VAR")
                    .frame(maxWidth: .infinity)
            }
        }
        
        if(gameController.getVarVideoLocation() != "") {
            let fileName = gameController.getVarVideoLocation().split(separator: "/").last!
            Text(String("Record: " + fileName))
        }
        
        Divider()
    }
}
