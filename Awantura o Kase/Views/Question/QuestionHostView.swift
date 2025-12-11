import SwiftUI
import AVFoundation
import AVKit

struct QuestionHostView: View {
    @Bindable private var controller = QuestionController.shared
    
    var body: some View {
        ScrollView {
            VStack {
                MyHeader(header: "Question")
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Q: \(controller.getQuestionBody())")
                            .font(.title)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("A: \(controller.getQuestionAnswer())")
                            .font(.body)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("\(controller.getTimeFormatted())")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 4)
                }
                        
                if(controller.getAttachmentType() != "none") {
                    Divider()
                    
                    HStack {
                        Text("Attachment")
                            .font(.title2)
                        
                        Toggle("", isOn: $controller.showAttachment)
                            .controlSize(.small)
                            .toggleStyle(.switch)
                    }

                    let attachmentType = controller.getAttachmentType()
                    
                    if(attachmentType == "image") {
                        if let nsImage = NSImage(contentsOf: controller.getAttachmentURL()) {
                            Image(nsImage: nsImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 400)
                        }
                    }
                    
                    else if (attachmentType == "video") {
                        VideoPlayer(player: controller.attachmentVideoPlayer)
                            .frame(maxHeight: 800)
                    }
                    
                    else if(attachmentType == "audio") {
                        Button("Play audio") {
                            controller.playAudioAttachment()
                        }
                    }
                }
                        
                        
                Divider()
                
                Text("Timer control")
                    .font(.title2)
                
                HStack(spacing: 10) {
                    Button("Start") { controller.startTimer() }.frame(maxWidth: .infinity)
                    Button("Stop") { controller.stopTimer() }.frame(maxWidth: .infinity)
                    Button("Reset") { controller.resetTimer() }.frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Divider()
                        
                Text("Answer and hints")
                    .font(.title2)
                
                HStack(spacing: 12) {
                    Button("Sell hint") {
                        controller.showSellHint = true
                    }
                    .popover(isPresented: $controller.showSellHint) {
                        NumberInputPopover(
                            message: "Sell hint for",
                            onConfirm: { number in
                                controller.sellHintFor(number)
                            },
                            onAppear: {
                                controller.stopTimer()
                            },
                            onCancel: {
                                controller.startTimer()
                            }
                            
                        )
                        .frame(width: 240)
                    }
                    
                    Button("Correct Answer") { controller.correctAnswer() }
                    Button("Incorrect Answer") { controller.incorrectAnswer() }
                    Button("Next turn") { controller.nextTurn() }
                }
                
                Spacer()
            }
            .padding()
        }
        
    }
}

//{"category":"Sztuka", "body":"XXX", "correctAnser":"XXX", "hintA":"XXX","hintB":"XXX", "hintC":"XXX","asked":false,"attachmentPath":"6.jpg"},
