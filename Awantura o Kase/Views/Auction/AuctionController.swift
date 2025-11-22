import SwiftUI
import Foundation
import OBSAsyncAPI
import os

@Observable
class AuctionController {
    static let shared = AuctionController()
    
    private(set) var selectedTeam: TeamColor?
    
    private(set) var winningTeam: TeamColor?
    private(set) var currentBid: Int = 0
    
    var temporaryInput: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
    var bidAmount: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
    
    var timer = Timer()
    var logger = Logger()
    
    // TODO: Move to settings
    var tvFontSize = CGFloat(70)
    
    private let gameController = GameController.shared
    
    private init() {
        
    }
    
    /// Method is used to point
    /// - Parameter color: which team is selected
    func selectTeam(_ color: TeamColor) {
        resetTemporaryInput()
        selectedTeam = color
    }
    
    func outbid(team: TeamColor, amount: Int) {
        let actualAmount = amount * 100
        
        if actualAmount <= currentBid{
            return
        }
        
        // Can not place a bid when you're not rich enought :)
        if gameController.getBalance(ofTeam: team) + getBid(ofTeam: team) < actualAmount {
            return
        }
        
        currentBid = actualAmount
        let amountDifference = actualAmount - bidAmount[team]!
        
        bidAmount[team]! = currentBid
        winningTeam = team
        
        gameController.deduct(fromTeam: team, amount: amountDifference)
        gameController.increasePool(amount: amountDifference)
        resetTemporaryInput()
    }
    
    public func getBid(ofTeam team: TeamColor) -> Int {
        return bidAmount[team]!
    }
    
    /// Method returns balance of team
    public func getBalance(ofTeam team: TeamColor) -> Int {
        gameController.getBalance(ofTeam: team)
    }
    
    public func getPoolOfMoney() -> Int {
        gameController.getPoolOfMoney()
    }
    
    func getTeams() -> [Team] {
        return gameController.getTeams()
    }
    
    func getTeam(ofColor color: TeamColor) -> Team {
        return gameController.getTeam(ofColor: color)
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
