import SwiftUI
import Foundation
import AVFoundation
import os

@Observable
class ReelController {
    static let shared = ReelController()
    
    private var audioPlayer: AVAudioPlayer?
    
    var isSpinning = false
    var categories: [String]
    var selectedCategory: String? = nil
    var winningIndex: Int? = nil
    var animationDuration: Double? = nil
    
    private init() {
        self.categories = ["Matematyka", "Mity i dzieje starożytne", "Fizyka",
        "Chemia Organiczna", "Historia Sztuki", "Geografia",
        "Informatyka", "Biologia", "Literatura Piękna"]
        
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
    }
    
    public func getWinningIndex() -> Int {
        if winningIndex == nil {
            findWinner()
        }
        
        return winningIndex!
    }
    
}
