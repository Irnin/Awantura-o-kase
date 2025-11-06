import Foundation

class Team: Identifiable {
    var id: TeamColor
    var name: String
    var balance: Int = 10_000
    
    init(color: TeamColor) {
        self.id = color
        
        switch color {
            case .blue:
                name = "Niebiescy"
            case .green:
                name = "Zieloni"
            case .yellow:
                name = "Żółti"
        }
    }
    
    public func add(money: Int) -> Int{
        balance += money
        return balance
    }
}
