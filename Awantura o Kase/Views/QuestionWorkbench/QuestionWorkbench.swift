import SwiftUI

struct QuestionWorkbench: View {
    @Bindable var gameController = GameController.shared
    @State private var selectedQuestions = Set<Question.ID>()
    
    var body: some View {
        Table(gameController.getQuestions(), selection: $selectedQuestions) {
            TableColumn("Category", value: \.category)
            TableColumn("Body", value: \.body)
            TableColumn("Correct", value: \.correctAnser)
            TableColumn("hintA", value: \.hintA)
            TableColumn("hintB", value: \.hintB)
            TableColumn("hintC", value: \.hintC)
            TableColumn("Asked", value: \.wasAsked)
        }
    }
}
