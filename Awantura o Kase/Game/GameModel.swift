import Foundation
import os

struct GameModel {
    let logger = Logger()
    
    // Preparring game
    var gameState: GameState = .preGame
    var tvScene: TVscene = .preGame
    
    // Teams
    var teams: [Team] = []
    
    // Auction
    var poolOfMoney: Int = 0
    var auctionWinner: TeamColor? = nil
    
    // VAR
    var currentVARrecord: String = ""
    var isVARreocording: Bool = false
    
    // Questions
    var questionsDatabasePath: String = "/Users/lukaszmichalak/Documents/categories.json"
    var questions: [Question] = []
    var currentCategory: String = ""
    var questionNumber: Int = 0
    
    // Media
    var playSounds: Bool = true
    
    init() {
        // Preaparing teams
        teams.removeAll()
        teams.append(Team(color: .blue))
        teams.append(Team(color: .green))
        teams.append(Team(color: .yellow))
        
        // Questions
        self.readQuestionsFromJson()
    }
    
    public func getTeam(withColor color: TeamColor) -> Team {
        let team = teams.first(where: { $0.id == color })
        return team!
    }
    
    mutating func addBalance(forTeam team: TeamColor, balance: Int) {
        let team = getTeam(withColor: team)
        team.balance += balance
    }
}

// MARK: - Controlling VAR
extension GameModel {
    public mutating func saveVARrecordPath(_ path: String) {
        self.currentVARrecord = path
    }
    
    public func getVARrecordPath() -> String {
        return self.currentVARrecord
    }
    
    public mutating func setStateOfVarRecording(_ isRecording: Bool) {
        self.isVARreocording = isRecording
    }
    
    public func getStateOfVarRecording() -> Bool {
        return self.isVARreocording
    }
}

// MARK: - Questions
extension GameModel {
    private mutating func readQuestionsFromJson() {
        let path = self.questionsDatabasePath
        
        guard let url = URL(string: path) else {
            logger.debug("Can not read from \(path)")
            return
        }
        
        do {
            let fileHandle = try FileHandle(forReadingFrom: url)
            let data = fileHandle.readDataToEndOfFile()
            fileHandle.closeFile()
            
            let decoder = JSONDecoder()
            self.questions = try decoder.decode([Question].self, from: data)
            
        } catch {
            logger.error("Can not read data from file \(path):")
            logger.error("\(error)")
        }
    }
}

// MARK: - Controlling TV view
extension GameModel {
    public mutating func setTvScene(_ view: TVscene){
        self.tvScene = view
    }
    
    public func getTvScene() -> TVscene {
        return self.tvScene
    }
}
