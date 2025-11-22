import SwiftUI
import PoweredTouchBar
import AppKit

struct AuctionHostView: View {
    @Bindable private var controller = AuctionController.shared
    @FocusState private var selectedTeam: TeamColor?
    @State var showInspector = true
    
    var body: some View {
        VStack {
            Text("Auction")
                .font(.title)
                .foregroundColor(.accentColor)
            
            Text(String(controller.counter))
            
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                GridRow {
                    Text("\(controller.getWinnerTeamName()) \(controller.getCurrentBind())")
                        .font(.system(size: 20, weight: .bold))
                        .gridCellColumns(5)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(controller.getWinnerTeamColor())
                }
                
                GridRow {
                    Text("Team")
                        .frame(maxWidth: .infinity)
                    
                    ForEach(controller.getTeams()) { team in
                        Text(team.name)
                            .bold()
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(team.color)
                    }
                    
                    Text("Pula")
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                
                GridRow {
                    Text("Auction input")
                        .frame(maxWidth: .infinity, minHeight: 44)
                    
                    ForEach(controller.getTeams()) { team in
                        TextField("", value: $controller.temporaryInput[team.id], format: .number)
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(team.color)
                            .foregroundColor(.white)
                            .focused($selectedTeam, equals: team.id)
                            .onKeyPress { keyPress in
                                if keyPress.key == .space {
                                    controller.outbid(team: team.id, amount: controller.temporaryInput[team.id]!)
                                    return .handled
                                }
                                return .ignored
                            }
                    }
                    
                    Text("\(controller.getPoolOfMoney())")
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                
                GridRow {
                    Text("Auction")
                        .frame(maxWidth: .infinity, minHeight: 44)
                    
                    ForEach(controller.getTeams()) { team in
                        Text("\(controller.bidAmount[team.id]!)")
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(team.color)
                            .foregroundColor(.white)
                    }
                    
                    Text("Pula Admina:")
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                
                GridRow {
                    Text("Stan Konta")
                        .frame(maxWidth: .infinity, minHeight: 44)
                
                    ForEach(controller.getTeams()) { team in
                        Text("\(controller.getBalance(ofTeam: team.id))")
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(team.color)
                            .foregroundColor(.white)
                    }
                    
                    Text("N/A")
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
            }
        }
        .poweredTouchBar {
            let blueTeam = controller.getTeam(ofColor: .blue)
            let greenTeam = controller.getTeam(ofColor: .green)
            let yellowTeam = controller.getTeam(ofColor: .yellow)
            
            PoweredColorButton(
                identifier: "blueTouchBarButton",
                title: blueTeam.name,
                color: NSColor(blueTeam.color),
                action: {
                    controller.selectTeam(.blue)
                    selectedTeam = .blue
                }
            )
            
            PoweredColorButton(
                identifier: "greenTouchBarButton",
                title: greenTeam.name,
                color: NSColor(greenTeam.color),
                action: {
                    controller.selectTeam(.green)
                    selectedTeam = .green
                }
            )
            
            PoweredColorButton(
                identifier: "yellowTouchBarButton",
                title: yellowTeam.name,
                color: NSColor(yellowTeam.color),
                action: {
                    controller.selectTeam(.yellow)
                    selectedTeam = .yellow
                }
            )
        }
    }
}
