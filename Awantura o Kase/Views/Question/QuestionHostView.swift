import SwiftUI

struct QuestionHostView: View {
    private var controller = QuestionController.shared
    
    var body: some View {
        
        VStack {
            MyHeader(header: "Question")
            
            Spacer()
            
            HStack(alignment: .top, spacing: 20) {

                GroupBox("Question") {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(controller.getQuestionBody())
                            .font(.body)
                            .padding(.bottom, 4)

                        Button("Find question") {
                            controller.findQuestion()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Show hints") {
                            controller.showHintForPlayer()
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: 300)

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
            }
            
            Spacer()
        }
        .padding(20)
    }

}
