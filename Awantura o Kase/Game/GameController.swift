import Foundation

@Observable
class GameController {
    static let shared = GameController()
    private var game: GameModel
    
    public var hostScene: HostScene = .preGame
    
    // MARK: - Game State
    public func getCurrentGameState() -> GameState {
        return game.gameState
    }
    
    public func setCurrentGameState(_ gameState: GameState) {
        game.gameState = gameState
    }
    
    public func setAuctionWinner(_ team: TeamColor) {
        game.auctionWinner = team
    }
    
    public func getAuctionWinner() -> TeamColor? {
        return game.auctionWinner
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

// MARK: - Managing money
extension GameController {
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
}

// MARK: - VAR
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

// MARK: - Questions
extension GameController {
    public func getCategories() -> Set<String> {
        
        return Set(game.questions.map { $0.category })
    }
    
    public func getCurrentCategory() -> String {
        return game.currentCategory
    }
    
    public func getQuestions() -> [Question] {
        return game.questions
    }
    
    public func getQuestionNumber() -> Int {
        return game.questionNumber
    }
    
    public func selectCategory(_ category: String) {
        game.currentCategory = category
    }
    
    public func getQuestionForCurrentCategory() -> Question? {
        let currentCategory = game.currentCategory
        return getQuestionOf(category: currentCategory)
    }
    
    public func getQuestionOf(category: String) -> Question? {
        let categoryQuestions = game.questions.filter({$0.category == category  && $0.asked == false})
        let question = categoryQuestions.randomElement()
        question?.asked = true
        
        return question
    }
}

// MARK: - Media
extension GameController {
    public func allowToPlaySounds(_ value: Bool) {
        game.playSounds = value
    }
    
    public func canPlaySounds() -> Bool {
        return game.playSounds
    }
}

// MARK: - Game stages
extension GameController {
    
    public func startGame() {
        self.jumpToDrawCategory()
    }
    
    public func jumpToDrawCategory() {
        game.gameState = .drawCategory
        
        setTvScene(.drawCategory)
        setHostScene(.drawCategory)
    }
    
    public func jumpToAuction() {
        game.gameState = .auction
        
        setTvScene(.auction)
        setHostScene(.auction)
    }
    
    public func jumpToQuestion() {
        game.gameState = .question
        
        setTvScene(.question)
        setHostScene(.question)
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

// MARK: - Controlling Host View
extension GameController {
    public func setHostScene(_ scene: HostScene) {
        hostScene = scene
    }
    
    public func getHostScene() -> HostScene {
        return hostScene
    }
}
