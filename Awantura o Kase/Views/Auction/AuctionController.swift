import SwiftUI
import Foundation
import OBSAsyncAPI
import os

@Observable
class AuctionController {
    static let shared = AuctionController()
    
    // Dependency
    private let controller = GameController.shared
    
    // Variables
    private(set) var selectedTeam: TeamColor?
    
    private(set) var auctionWinner: TeamColor?
    private(set) var currentBid: Int = 0
    
    public var auctionStarted = false
    
    var temporaryInput: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
    var bidAmount: [TeamColor: Int] = [.blue: 0, .green: 0, .yellow: 0]
    
    var timer = Timer()
    var logger = Logger()
    
    // TODO: Move to settings
    var tvFontSize = CGFloat(70)
    
    private let gameController = GameController.shared
    
    private init() {
        
    }
    
    public func reset() {
        currentBid = 0
        
        bidAmount[.blue] = 0
        bidAmount[.green] = 0
        bidAmount[.yellow] = 0
        
        selectedTeam = nil
        auctionWinner = nil
        
        auctionStarted = false
    }
    
    /// Method is used to point
    /// - Parameter color: which team is selected
    func selectTeam(_ color: TeamColor) {
        resetTemporaryInput()
        selectedTeam = color
    }
    
    public func startAuction() {
        if(auctionStarted) {
            return
        }
        
        auctionStarted = true
        
        let amount = 500
        
        self.startAuctionForTeam(.blue, amount: amount)
        self.startAuctionForTeam(.green, amount: amount)
        self.startAuctionForTeam(.yellow, amount: amount)
    }
    
    private func startAuctionForTeam(_ team: TeamColor, amount: Int) {
        
        // Team can not play
        if gameController.getBalance(ofTeam: team) + getBid(ofTeam: team) < amount {
            return
        }
        
        bidAmount[team]! = amount
        gameController.deduct(fromTeam: team, amount: amount)
        gameController.increasePool(amount: amount)
    }
    
    func vabank() {
        let team = selectedTeam!
        
        let bid = bidAmount[team]!
        let balance = controller.getBalance(ofTeam: team)
        let amount = balance + bid
        
        outbid(team: team, amount: Int(amount/100))
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
        auctionWinner = team
        controller.setAuctionWinner(team)
        
        gameController.deduct(fromTeam: team, amount: amountDifference)
        gameController.increasePool(amount: amountDifference)
        resetTemporaryInput()
    }
    
    public func givePenalty(amount: Int) {
        guard let team = selectedTeam else {
            return
        }
        
        gameController.deduct(fromTeam: team, amount: amount)
        gameController.increaseHostPool(amount: amount)
    }
    
    public func incrementPoolFromHost(amount: Int) {
        gameController.decreaseHostPool(amount: amount)
        gameController.increasePool(amount: amount)
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
        guard let team = auctionWinner else {
            return ""
        }
        
        return gameController.getTeam(ofColor: team).name
    }
    
    public func getWinnerTeamColor() -> Color {
        guard let team = auctionWinner else {
            return Color.clear
        }
        
        return gameController.getTeam(ofColor: team).color
    }
    
    public func getSelectedTeamName() -> String {
        guard let selectedTeamName = selectedTeam else {
            return ""
        }
        
        return gameController.getTeam(ofColor: selectedTeamName).name
    }
    
    public func getSelectedTeamColor() -> Color {
        guard let selectedTeamColor = selectedTeam else {
            return Color.clear
        }
        
        return gameController.getTeam(ofColor: selectedTeamColor).color
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
