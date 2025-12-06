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
    
    var timer = Timer()
    private var timeLeft: Int = 60
    private var timerOn: Bool = false
    
    // Methods
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
    }
    
    public func getQuestionBody() -> String {
        guard let body = currentQuestion?.body else {
            return ""
        }
        
        return body
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
    }
    
    public func getTimeFormatted() -> String {
        return timeLeft == 60 ? "1:00" : "0:\(timeLeft)"
    }
}
