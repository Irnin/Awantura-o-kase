import SwiftUI
import Foundation
import OBSAsyncAPI
import os
import AVFoundation

@Observable
class VARController {
    static let shared = VARController()
    private(set) var player: AVPlayer = AVPlayer()
    
    public func setPlayer(url: URL) {
        let item = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: item)
    }
}
