import SwiftUI

struct Inspector: View {
    @Bindable var gameController = GameController.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            BasicInformationsInspector()
            VARInspector()
            TVInspector()
            Spacer()
        }
        .padding(.horizontal, 10)
        .inspectorColumnWidth(min: 100, ideal: 200, max: 500)
    }
}
