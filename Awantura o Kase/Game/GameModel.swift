struct GameModel {
    var teams: [Team] = []
    
    init() {
        
        // Preaparing teams
        teams.removeAll()
        teams.append(Team(color: .blue))
        teams.append(Team(color: .green))
        teams.append(Team(color: .yellow))
    }
    
    public func getTeam(withColor color: TeamColor) -> Team? {
        return teams.first(where: { $0.id == color })
    }
}
