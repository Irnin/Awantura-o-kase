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
