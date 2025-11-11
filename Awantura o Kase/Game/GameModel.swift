struct GameModel {
    var gameState: GameState = .preGame
    var teams: [Team] = []
    var poolOfMoney: Int = 0
    
    init() {
        
        // Preaparing teams
        teams.removeAll()
        teams.append(Team(color: .blue))
        teams.append(Team(color: .green))
        teams.append(Team(color: .yellow))
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
