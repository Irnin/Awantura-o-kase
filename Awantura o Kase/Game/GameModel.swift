struct GameModel {
    var gameState: GameState = .preGame
    var tvScene: TVscene = .preGame
    var teams: [Team] = []
    var poolOfMoney: Int = 0
    
    // VAR
    var currentVARrecord: String = ""
    var isVARreocording: Bool = false
    
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

// MARK: - Controlling TV view
extension GameModel {
    public mutating func setTvScene(_ view: TVscene){
        self.tvScene = view
    }
    
    public func getTvScene() -> TVscene {
        return self.tvScene
    }
}
