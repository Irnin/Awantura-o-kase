import SwiftUI

struct TvView: View {
    private let gameController = GameController.shared
    
    var body: some View {
        ZStack {
            switch gameController.getTvScene() {
            case .preGame:
                PreGameView()
            case .drawCategory:
                ReelTvView()
            case .auction:
                AuctionTvView()
            case .question:
                QuestionTvView()
            case .correctAnswer:
                CorrectAnswerTvView()
            case .ads:
                AdPlayerTvView()
            case .varReplay:
                VARTvView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
