import SwiftUI

struct SellHintSubView: View {
    public var controller: QuestionController
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text(String(controller.getTeamName()))
                .font(Font.custom("Windows Dots", size: 70))
                .minimumScaleFactor(0.1)
                .padding(30)
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .background(Color.black)
                .foregroundColor(Color.white)
                .font(.headline)
            
            Text("\(controller.getTeamBalance())")
                .font(Font.custom("LED counter 7", size: 90))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .bold()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding(30)
                .background(controller.getTeamColor())
            
            Spacer()
        }
    }
}
