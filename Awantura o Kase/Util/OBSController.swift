import OBSAsyncAPI
import OBSWebsocket
import Combine
import Foundation
import os

class OBSController {
    static let shared = OBSController()
    let client: OBSClient = OBSClient(port: 4455)
    let logger = Logger()
    
    private var gameController = GameController.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    func connect() async {
        logger.info("Conntecting to OBS")
        
        do {
            try await client.connect()
        } catch {
            let message = error.localizedDescription
            logger.error("\(message)")
        }
    }
    
    
    private init() {
        logger.info("Building OBSController")
        
        Task {
            client.events
                .sink { event in
                    switch(event) {
                    case .replayBufferSaved(let info):
                        let savedPath = info.savedReplayPath
                        self.logger.info("Saved replay buffer to \(savedPath)")
                        self.gameController.saveVarVideoLocation(at: savedPath)
                        break
                        
                    case .replayBufferStateChanged(let info):
                        self.gameController.setStateOfVarRecording(info.outputActive)
                        let message = info.outputActive ? "active" : "inactive"
                        self.logger.info("Replay buffer state is \(message)")
                        break
                        
                    default: break
                    }
                }
                .store(in: &cancellables)
            
            await self.connect()
        }
    }
    
    public func startReplyBuffer() async {
        logger.info("Starting replay buffer")
        
        do {
            try await self.client.startReplayBuffer()
        }
        catch {
            let message = error.localizedDescription
            logger.error("\(message)")
        }
    }
    
    public func stopReplyBuffer() async {
        logger.info("Stopping replay buffer")
        
        do {
            try await self.client.stopReplayBuffer()
        }
        catch {
            let message = error.localizedDescription
            logger.error("\(message)")
        }
    }
    
    public func saveReplyBuffer() async {
        logger.info("Saving replay buffer")
        
        do {
            try await self.client.saveReplayBuffer()
        }
        catch {
            let message = error.localizedDescription
            logger.error("\(message)")
        }
    }
}
