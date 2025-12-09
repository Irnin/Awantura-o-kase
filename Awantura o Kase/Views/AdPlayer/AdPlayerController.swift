import SwiftUI
import Foundation
import OBSAsyncAPI
import os
import AVFoundation

@Observable
class AdPlayerController {
    static let shared = AdPlayerController()
    
    // Folder z reklamami
    public var path = "/Users/lukaszmichalak/myDocuments/Projects/Awantura o kase/Awantura o kase II Edycja/Assets/Movies/ads"
    
    private(set) var videos: [URL] = []
    
    private(set) var player: AVPlayer = AVPlayer()
    private var currentIndex: Int = 0

    init() {
        loadVideos()
        setupPlayerObserver()
    }
    
    // MARK: Load Files
    public func loadVideos() {
        let url = URL(fileURLWithPath: path)
        let fm = FileManager.default
        
        guard let items = try? fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        else { return }
        
        // Filtrujemy tylko filmy
        self.videos = items
            .filter { $0.pathExtension.lowercased().contains("mp4") }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
    }
    
    // MARK: Player
    public func play(index: Int) {
        guard videos.indices.contains(index) else { return }
        
        currentIndex = index
        let item = AVPlayerItem(url: videos[index])
        player.replaceCurrentItem(with: item)
        player.play()
    }
    
    public func playNext() {
        let next = currentIndex + 1
        if videos.indices.contains(next) {
            play(index: next)
        } else {
            play(index: 0)
        }
    }
    
    private func setupPlayerObserver() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.playNext()
        }
    }
}

