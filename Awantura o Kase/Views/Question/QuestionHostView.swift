import SwiftUI

struct QuestionHostView: View {
    private var controller = QuestionController.shared
    
    var body: some View {
        VStack {
            Text("Question: \(controller.getQuestionBody())")
            
            Button("Get Question") {
                controller.findQuestion()
            }
        }
    }
}
