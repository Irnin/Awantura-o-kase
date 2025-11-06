import SwiftUI

extension AuctionAdminView {
    
    @Observable
    class ViewModel {
        private let gameController = GameController.shared
        private(set) var selectedTeam: TeamColor?
        
        var temporaryInput: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
        var bidAmount: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
        
        func selectTeam(_ color: TeamColor) {
            selectedTeam = color
        }
        
        func something(team: TeamColor, amount: Int) {
            let actualAmount = amount * 100
            bidAmount[team]! += actualAmount
            gameController.deduct(fromTeam: team, amount: actualAmount)
            resetTemporaryInput()
        }
        
        public func getBalance(ofTeam team: TeamColor) -> Int {
            gameController.getBalance(ofTeam: team)
        }
        
        private func resetTemporaryInput() {
            temporaryInput[.blue] = 0
            temporaryInput[.green] = 0
            temporaryInput[.yellow] = 0
        }
    }
}
