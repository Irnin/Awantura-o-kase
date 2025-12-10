import SwiftUI

struct QuestionSubView: View {
    public var controller: QuestionController
    
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
                let hint = controller.getHint()
                
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        Text(hint[0])
                            .font(.system(size: 20, weight: .bold))
                            .gridCellColumns(5)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(controller.getTeamColor())
                        
                        Text(hint[1])
                            .font(.system(size: 20, weight: .bold))
                            .gridCellColumns(5)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(controller.getTeamColor())
                    }
                    
                    GridRow {
                        Text(hint[2])
                            .font(.system(size: 20, weight: .bold))
                            .gridCellColumns(5)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(controller.getTeamColor())
                        
                        Text(hint[3])
                            .font(.system(size: 20, weight: .bold))
                            .gridCellColumns(5)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(controller.getTeamColor())
                    }
                }
                .background(controller.getTeamColor())
                
            }
        }
    }
}
