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
                self.color = Color.blue
                name = "Niebiescy"
            case .green:
                self.color = Color.green
                name = "Zieloni"
            case .yellow:
                self.color = Color.yellow
                name = "Żółti"
        }
    }
    
    public func add(money: Int) -> Int{
        balance += money
        return balance
    }
}
