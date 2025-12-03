import SwiftUI

struct QuestionTvView: View {
    private var controller = QuestionController.shared
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("PYTANIE \(controller.getQuestionNumber())")
                    .font(.system(size: 30, weight: .bold))
                
                Spacer()
                
                Text("DO WYGRANIA \(controller.getPoolOfMoney()) ZŁ")
                    .font(.system(size: 30, weight: .bold))
            }
            .padding(20)
            .background(Color.black)
            
            HStack {
                Spacer()
                
                Text(controller.getQuestionBody())
                    .font(.system(size: 30, weight: .bold))
                
                Spacer()
            }
            .padding(20)
            .background(controller.getTeamColor())
        }
    }
}
