import SwiftUI

struct QuestionTvView: View {
    private var controller = QuestionController.shared
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
                
                Text("\(controller.getTimeFormatted())")
                    .font(Font.custom("LED counter 7", size: 160))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .bold()
                    .font(.headline)
                    .padding(20)
            }
            
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
