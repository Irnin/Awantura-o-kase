import SwiftUI
import Foundation
import os

@Observable
class QuestionController {
    static let shared = QuestionController()
    
    // Dependency
    private var controller = GameController.shared
    
    // Variables
    private var currentQuestion: Question?
    private(set) var showHint: Bool = false
    private(set) var hints: [String] = []
    
    var timer = Timer()
    private var timeLeft: Int = 60
    private var timerOn: Bool = false
    
    // Variables to winning animation
    public var startMoneyAnimation: Int = 0
    public var endMoneyAnimation: Int = 0
    
    // Methods
    public func reset() {
        currentQuestion = nil
        timer.invalidate()
        timeLeft = 60
        timerOn = false
        showHint = false
    }
    
    public func getQuestionNumber() -> String {
        return String(controller.getQuestionNumber())
    }
    
    public func getPoolOfMoney() -> String {
        return String(controller.getPoolOfMoney())
    }
    
    public func getTeamColor() -> Color{
        guard let auctionWinner = controller.getAuctionWinner() else {
            return Color.pink
        }
        
        let team = controller.getTeam(ofColor: auctionWinner)
        return team.color
    }
    
    public func findQuestion() {
        currentQuestion = controller.getQuestionForCurrentCategory()
        
        hints = currentQuestion!.getHits()
    }
    
    public func getQuestionBody() -> String {
        guard let body = currentQuestion?.body else {
            return ""
        }
        
        return body
    }
    
    public func getHint() -> [String] {
        return hints
    }
    
    public func showHintForPlayer() {
        showHint = true
        
    }
    
    public func containAttachment() -> Bool {
        guard let question = currentQuestion else {
            return false
        }
        
        if(question.attachmentType() == "none") {
            return false
        }
        
        return true
    }
}

extension QuestionController {
    public func correctAnswer() {
        guard let auctionWinner = controller.getAuctionWinner() else {
            return
        }
        
        let amount = controller.getPoolOfMoney()
        controller.emptyPool()
        
        startMoneyAnimation = controller.getBalance(ofTeam: auctionWinner)
        endMoneyAnimation = startMoneyAnimation + amount
        
        controller.addBalance(team: auctionWinner, amount: amount)
        controller.setTvScene(.correctAnswer)
    }
    
    public func incorrectAnswer() {
        
    }
    
    public func nextTurn() {
        startMoneyAnimation = 0
        startMoneyAnimation = 0
        timeLeft = 60
        
        controller.nextTurn()
    }
}

extension QuestionController {
    public func resetTimer() {
        timeLeft = 60
        timerOn = false
    }
    
    public func startTimer() {
        timerOn = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timerClick()
        })
    }
    
    public func stopTimer() {
        timerOn = false
        timer.invalidate()
    }
    
    private func timerClick() {
        self.timeLeft -= 1
        
        if(self.timeLeft == 0) {
            self.stopTimer()
        }
    }
    
    public func getTimeFormatted() -> String {
        return timeLeft == 60 ? "1:00" : "0:\(timeLeft)"
    }
}
