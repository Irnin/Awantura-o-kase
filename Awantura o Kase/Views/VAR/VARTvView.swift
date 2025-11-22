import SwiftUI
import PoweredTouchBar
import AVKit

struct VARTvView: View {
    private let varController = VARController.shared
    
    var body: some View {
        VideoPlayer(player: varController.player)
            .frame(minWidth: 400, minHeight: 300)
    }
}
