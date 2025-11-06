import Foundation

@Observable
class GameController {
    static let shared = GameController()
    
    private var game: GameModel
    
    private init() {
        game = GameModel()
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
}
