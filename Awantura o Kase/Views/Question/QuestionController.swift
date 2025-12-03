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
