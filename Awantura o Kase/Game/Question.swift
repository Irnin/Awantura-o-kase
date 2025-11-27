struct Question {
    public var body: String
    public var correctAnser: String
    public var hintA: String
    public var hintB: String
    public var hintC: String
    public var asked: Bool = false
    
    public func getHit() -> [String] {
        return [correctAnser, hintA, hintB, hintC].shuffled()
    }
}
