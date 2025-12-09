import SwiftUI
import PoweredTouchBar
import AVKit

struct AdPlayerTvView: View {
    
    @Bindable private var controller = AdPlayerController.shared
    
    var body: some View {
        VideoPlayer(player: controller.player)
            .frame(minWidth: 400, minHeight: 300)
    }
}
