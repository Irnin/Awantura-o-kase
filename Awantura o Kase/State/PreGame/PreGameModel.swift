import SwiftUI

extension PreGameView {
    
    @Observable
    class ViewModel {
        private let gameController = GameController.shared
        
        func startGame() {
            gameController.startGame()
        }
        
    }
}
