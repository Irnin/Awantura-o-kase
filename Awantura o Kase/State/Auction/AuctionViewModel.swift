import SwiftUI

extension AuctionAdminView {
    
    @Observable
    class ViewModel {
        private let gameController = GameController.shared
        private(set) var selectedTeam: TeamColor?
        
        private(set) var winningTeam: TeamColor?
        private(set) var currentBid: Int = 0
        
        var temporaryInput: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
        var bidAmount: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
        
        func selectTeam(_ color: TeamColor) {
            resetTemporaryInput()
            selectedTeam = color
        }
        
        func outbid(team: TeamColor, amount: Int) {
            let actualAmount = amount * 100
            
            if actualAmount <= currentBid{
                return
            }
            
            currentBid = actualAmount
            
            bidAmount[team]! += currentBid
            winningTeam = team
            
            gameController.deduct(fromTeam: team, amount: currentBid)
            gameController.increasePool(amount: currentBid)
            resetTemporaryInput()
        }
        
        public func getBalance(ofTeam team: TeamColor) -> Int {
            gameController.getBalance(ofTeam: team)
        }
        
        public func getPoolOfMoney() -> Int {
            gameController.getPoolOfMoney()
        }
        
        // MARK: - Get winner details
        public func getWinnerTeamName() -> String {
            guard let team = winningTeam else {
                return ""
            }
            
            return gameController.getTeam(ofColor: team).name
        }
        
        public func getWinnerTeamColor() -> Color {
            guard let team = winningTeam else {
                return Color.clear
            }
            
            return gameController.getTeam(ofColor: team).color
        }
        
        public func getCurrentBind() -> String {
            if currentBid == 0 {
                return ""
            }
            
            return String(currentBid)
        }
        
        // MARK: - Setting up
        private func resetTemporaryInput() {
            temporaryInput[.blue] = 0
            temporaryInput[.green] = 0
            temporaryInput[.yellow] = 0
        }
    }
}
