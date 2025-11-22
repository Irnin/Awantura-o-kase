import Foundation

@Observable
class GameController {
    static let shared = GameController()
    private var game: GameModel

    
    // MARK: - Game State
    public func startGame() {
        game.gameState = .auction
    }
    
    public func getCurrentGameState() -> GameState {
        return game.gameState
    }
    
    public func setCurrentGameState(_ gameState: GameState) {
        game.gameState = gameState
    }
    
    public func addBalance(team: TeamColor, amount: Int) {
        game.addBalance(forTeam: team, balance: amount)
    }
    
    public func deduct(fromTeam team: TeamColor, amount: Int) {
        let team = game.getTeam(withColor: team)
        team.balance -= amount
    }
    
    public func getBalance(ofTeam team: TeamColor) -> Int {
        let team = game.getTeam(withColor: team)
        return team.balance
    }
    
    public func increasePool(amount: Int) {
        game.poolOfMoney += amount
    }
    
    public func getPoolOfMoney() -> Int {
        return game.poolOfMoney
    }
    
    public func getTeams() -> [Team] {
        return game.teams
    }
    
    public func getTeam(ofColor color: TeamColor) -> Team {
        return game.getTeam(withColor: color)
    }
    
    private init() {
        game = GameModel()
    }
}

// MARK: - Controlling VAR
extension GameController {
    public func saveVarVideoLocation(at path: String) {
        let varController = VARController.shared
        varController.setPlayer(url: URL(fileURLWithPath: path))
        
        game.saveVARrecordPath(path)
    }
    
    public func getVarVideoLocation() -> String {
        return game.getVARrecordPath()
    }
    
    public func setStateOfVarRecording(_ isRecording: Bool) {
        game.setStateOfVarRecording(isRecording)
    }
    
    public func getStateOfVarRecording() -> Bool {
        return game.getStateOfVarRecording()
    }
}

// MARK: - Controlling TV
extension GameController {
    public func setTvScene(_ scene: TVscene) {
        game.setTvScene(scene)
    }
    
    public func getTvScene() -> TVscene {
        return game.getTvScene()
    }
}
