import SwiftUI

struct QuestionTvView: View {
    private var controller = QuestionController.shared
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack {
                Text("\(controller.getTimeFormatted())")
                    .font(Font.custom("LED counter 7", size: 160))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .bold()
                    .font(.headline)
                    .padding(20)
            }
            
            Spacer()
            
            if(controller.containAttachment()) {
                Text("Placeholder")
                
                Spacer()
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
            
            if(controller.getQuestionBody() != "") {
                HStack {
                    Text(controller.getQuestionBody())
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 30, weight: .bold))
                }
                .padding(20)
                .background(controller.getTeamColor())
            }
            
            
            if(controller.showHint) {
                HStack {
                    ForEach(controller.getHint(), id: \.self) { hint in
                        Text(hint)
                            .padding(20)
                            .font(.system(size: 30, weight: .bold))
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(20)
                .background(controller.getTeamColor())
            }
        }
    }
}
