import Foundation

enum HostScene: CaseIterable {
    case preGame
    case drawCategory
    case auction
    case question
    case ads
    case varReplay
    case questionWorkbench
    
    var displayName: String {
        switch(self) {
        case .preGame:
            return "Waiting time"
        case .drawCategory:
            return "Draw Category"
        case .auction:
            return "Auction"
        case .question:
            return "Question"
        case .ads:
            return "Ads"
        case .varReplay:
            return "VAR"
        case .questionWorkbench:
            return "Question Workbench"
        }
    }
}
