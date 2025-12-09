import SwiftUI
import PoweredTouchBar

struct CorrectAnswerTvView: View {
    @Bindable private var controller = GameController.shared
    @Bindable private var questionController = QuestionController.shared
    
    @State private var currentValue: Int = 0
    @State private var startTime: Date?
    
    let duration: Double = 3

    var body: some View {
        
        let from: Int = self.questionController.startMoneyAnimation
        let to: Int = self.questionController.endMoneyAnimation
        
        VStack(spacing: 0) {
            Spacer()
            
            Text("\(controller.getAuctionWinnerName())")
                .font(Font.custom("Windows Dots", size: 70))
                .minimumScaleFactor(0.1)
                .padding(30)
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .background(Color.black)
                .foregroundColor(controller.getAuctionWinnerColor())
                .font(.headline)
            
            Text("\(currentValue.formatted())")
                .font(Font.custom("LED counter 7", size: 90))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .bold()
                .frame(maxWidth: .infinity)
                .font(.headline)
                .padding(30)
                .background(controller.getAuctionWinnerColor())
                .onAppear {
                    animate(from: Double(from), to: Double(to))
                }
            
            Spacer()
        }
    }
    
    private func animate(from: Double, to: Double) {
        currentValue = Int(from)
        
        let start = Date()
        startTime = start
        
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { timer in
            let now = Date().timeIntervalSince(start)
            let progress = min(now / duration, 1)
            
            let currentDoubleValue = from + (to - from) * progress
            currentValue = Int(currentDoubleValue)
            
            if progress == 1 {
                timer.invalidate()
            }
        }
    }
}
