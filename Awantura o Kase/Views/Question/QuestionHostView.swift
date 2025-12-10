import SwiftUI

struct QuestionHostView: View {
    @Bindable private var controller = QuestionController.shared
    
    var body: some View {
        
        VStack {
            MyHeader(header: "Question")
            
            Spacer()
            
            GroupBox("Question") {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Question: \(controller.getQuestionBody())")
                        .font(.body)
                        .padding(.bottom, 4)
                    
                    Text("Answer: \(controller.getQuestionAnswer())")
                        .font(.body)
                        .padding(.bottom, 4)
                    
                    Text("Attachment: \(controller.getAttachmentType())")
                        .font(.body)
                        .padding(.bottom, 4)

                    Button("Find question") {
                        controller.findQuestion()
                    }
                    .buttonStyle(.borderedProminent)
                    
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
                    
                    Button("Show hints") {
                        controller.showHintForPlayer()
                    }
                }
                .padding()
            }
            .padding(30)
            .frame(maxWidth: .infinity)
            
            HStack(alignment: .top, spacing: 20) {

                GroupBox("Timer") {
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Timer: \(controller.getTimeFormatted())")
                            .font(.title3)
                            .bold()
                            .padding(.bottom, 4)

                        HStack(spacing: 10) {
                            Button("Start") { controller.startTimer() }
                            Button("Stop") { controller.stopTimer() }
                            Button("Reset") { controller.resetTimer() }
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                }
                .frame(maxWidth: 300)
                
                GroupBox("Answer") {
                    VStack(alignment: .leading, spacing: 12) {
                        Button("Correct Answer") { controller.correctAnswer() }
                        Button("Incorrect Answer") { controller.incorrectAnswer() }
                        Divider()
                        
                        Button("Next turn") { controller.nextTurn() }
                    }
                    .padding()
                }
                .frame(maxWidth: 300)
            }
            
            Spacer()
        }
        .padding(20)
    }

}
