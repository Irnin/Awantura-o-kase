import Foundation

@Observable
class GameController {
    private var game: GameModel
    
    init() {
        game = GameModel()
    }
    
    public func addBalance(team: TeamColor, amount: Int) {
        let team = game.getTeam(withColor: team)!
        _ = team.add(money: 300)
    }
}
