import Foundation
import SwiftUI

class Team: Identifiable {
    var id: TeamColor
    var name: String
    var balance: Int = 10_000
    var color: Color
    
    init(color: TeamColor) {
        self.id = color
        
        switch color {
            case .blue:
            self.color = Color(r: 12, g: 36, b: 94)
                name = "Niebiescy"
            case .green:
            self.color = Color(r: 32, g: 76, b: 18)
                name = "Zieloni"
            case .yellow:
            self.color = Color(r: 193, g: 157, b: 52)
                name = "Żółci"
        }
    }
    
    public func add(money: Int) -> Int{
        balance += money
        return balance
    }
}
