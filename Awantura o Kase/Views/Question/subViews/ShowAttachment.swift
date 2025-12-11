import SwiftUI
import AVKit

struct ShowAttachment: View {
    public var controller: QuestionController
    
    var body: some View {
        let attachmentType = controller.getAttachmentType()
        
        VStack(spacing: 0) {
            if(attachmentType == "image") {
                if let nsImage = NSImage(contentsOf: controller.getAttachmentURL()) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity,
                                   maxHeight: .infinity,
                                   alignment: .center)
                }
            }
            else if (attachmentType == "video") {
                VideoPlayer(player: controller.attachmentVideoPlayer)
                    .frame(minWidth: 400, minHeight: 300)
            }
            else if(attachmentType == "audio") {
                Image(systemName: "hifispeaker.2.fill")
            }
        }
    }
}
