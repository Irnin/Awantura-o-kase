import Foundation

enum TVscene: CaseIterable {
    case preGame
    case drawCategory
    case auction
    case ads
    case varReplay
    
    var displayName: String {
        switch(self) {
        case .preGame:
            return "Waiting time"
        case .drawCategory:
            return "Draw Category"
        case .auction:
            return "Auction"
        case .ads:
            return "Ads"
        case .varReplay:
            return "VAR"
        }
    }
}
