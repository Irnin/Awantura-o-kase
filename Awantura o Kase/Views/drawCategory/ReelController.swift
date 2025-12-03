import SwiftUI
import Foundation
import AVFoundation
import os

@Observable
class ReelController {
    static let shared = ReelController()
    
    private var controller = GameController.shared
    
    private var audioPlayer: AVAudioPlayer?
    
    var isSpinning = false
    var categories: [String]
    var selectedCategory: String? = nil
    var winningIndex: Int? = nil
    var winningCategory: String = ""
    var animationDuration: Double? = nil
    
    private init() {
        let gameController = GameController.shared
        self.categories = Array(gameController.getCategories())
        
        let url = URL(fileURLWithPath: "/Users/lukaszmichalak/myDocuments/Projects/Awantura o kase/Awantura o kase II Edycja/Assets/Audio/drawCategory.mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Błąd podczas odtwarzania: \(error.localizedDescription)")
        }
    }
    
    public func playSound() {
        audioPlayer?.play()
    }
    
    public func getCategories() -> [String] {
        return categories
    }
    
    private func findWinner() {
        winningIndex = categories.indices.randomElement() ?? 0
        controller.selectCategory(categories[winningIndex!])
    }
    
    public func getWinningIndex() -> Int {
        if winningIndex == nil {
            findWinner()
        }
        
        return winningIndex!
    }
    
    public func resetWinningIndex() {
        winningIndex = nil
    }
    
}
