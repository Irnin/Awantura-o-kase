import SwiftUI
import PoweredTouchBar
import AVKit

struct AdPlayerHostView: View {
    
    @Bindable private var controller = AdPlayerController.shared
    @Bindable private var gameController = GameController.shared
    
    var body: some View {
            VStack {
                // Player
                VideoPlayer(player: controller.player)
                    .frame(height: 300)

                HStack {
                    Button("Play Ads") {
                        gameController.setTvScene(.ads)
                        controller.play(index: 0)
                    }
                }
                List(controller.videos, id: \.self) { video in
                    Text(video.lastPathComponent)
                        .onTapGesture {
                            if let index = controller.videos.firstIndex(of: video) {
                                controller.play(index: index)
                            }
                        }
                }
            }
            .onAppear {
                controller.loadVideos()
            }
        }
}
