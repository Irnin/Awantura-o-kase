import SwiftUI
import Foundation
import AVFoundation
import os

@Observable
class QuestionController {
    static let shared = QuestionController()
    
    // Dependency
    private var controller = GameController.shared
    
    private var audioPlayer: AVAudioPlayer?
    
    // Variables
    private var currentQuestion: Question?
    private(set) var hints: [String] = []
    
    private var attachmentPath = "file:///Users/lukaszmichalak/myDocuments/Projects/Awantura o kase/Awantura o kase II Edycja/Assets/attachments/"
    
    public var showHint: Bool = false
    public var showSellHint = false
    public var showAttachment = false
    
    var timer = Timer()
    private var timeLeft: Int = 60
    private var timerOn: Bool = false
    
    private(set) var attachmentVideoPlayer: AVPlayer = AVPlayer()
    private var attachmentAudioPlayer: AVAudioPlayer?
    
    // Variables to winning animation
    public var startMoneyAnimation: Int = 0
    public var endMoneyAnimation: Int = 0
    
    private init() {
        let url = URL(fileURLWithPath: "/Users/lukaszmichalak/myDocuments/Projects/Awantura o kase/Awantura o kase II Edycja/Assets/Audio/winning.mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Błąd podczas odtwarzania: \(error.localizedDescription)")
        }
    }
    
    // Methods
    public func reset() {
        currentQuestion = nil
        timer.invalidate()
        timeLeft = 60
        timerOn = false
        showHint = false
        showSellHint = false
        showAttachment = false
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
    
    public func getTeamName() -> String {
        guard let auctionWinner = controller.getAuctionWinner() else {
            return "NO NAME TEAM"
        }
        
        let team = controller.getTeam(ofColor: auctionWinner)
        return team.name
    }
    
    public func getTeamBalance() -> Int {
        guard let auctionWinner = controller.getAuctionWinner() else {
            return 0
        }
        
        return controller.getBalance(ofTeam: auctionWinner)
    }
    
    public func findQuestion() {
        currentQuestion = controller.getQuestionForCurrentCategory()
        
        hints = currentQuestion!.getHits()
        
        // Attachment
        let attachmentType = getAttachmentType()
        
        if(attachmentType != "none") {
            showAttachment = true
        }
        
        if (attachmentType == "video") {
            let item = AVPlayerItem(url: getAttachmentURL())
            self.attachmentVideoPlayer = AVPlayer(playerItem: item)
            self.attachmentVideoPlayer.actionAtItemEnd = .pause
        }
        else if (attachmentType == "audio") {
            let url = getAttachmentURL()
            
            do {
                attachmentAudioPlayer = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("Can not load audio: \(error.localizedDescription)")
            }
        }
    }
    
    public func getQuestionBody() -> String {
        guard let body = currentQuestion?.body else {
            return ""
        }
        
        return body
    }
    
    public func getQuestionAnswer() -> String {
        guard let body = currentQuestion?.correctAnser else {
            return ""
        }
        
        return body
    }
    
    public func getHint() -> [String] {
        return hints
    }
    
    public func playAudioAttachment() {
        attachmentAudioPlayer?.play()
    }
    
    public func sellHintFor(_ amount: Int) {
        guard let team = controller.getAuctionWinner() else {
            return
        }
        
        if(controller.getBalance(ofTeam: team) < amount) {
            return
        }
        
        controller.increaseHostPool(amount: amount)
        controller.deduct(fromTeam: team, amount: amount)
        
        showHintForPlayer()
        timeLeft = 60
        startTimer()
    }
    
    public func showHintForPlayer() {
        showHint = true
    }
    
    public func getAttachmentType() -> String {
        guard let currentQuestion = currentQuestion else {
            return ""
        }
        
        return currentQuestion.attachmentType()
    }
    
    public func getAttachmentURL() -> URL {
        guard let question = currentQuestion else {
            return URL.homeDirectory
        }
        
        return URL(string: attachmentPath + question.attachmentPath)!
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

// MARK: - Answers
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
        audioPlayer?.play()
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

// MARK: - Timer
extension QuestionController {
    public func resetTimer() {
        timeLeft = 60
        timerOn = false
    }
    
    public func startTimer() {
        
        if(timerOn)  {
            return
        }
        
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
