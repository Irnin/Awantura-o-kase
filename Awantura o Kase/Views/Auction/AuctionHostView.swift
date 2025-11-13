import SwiftUI
import PoweredTouchBar
import AppKit

struct AuctionHostView: View {
    @Bindable private var viewModel = AuctionController.shared
    @FocusState private var selectedTeam: TeamColor?
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Text("\(viewModel.getWinnerTeamName()) \(viewModel.getCurrentBind())")
                    .font(.system(size: 20, weight: .bold))
                    .gridCellColumns(5)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(viewModel.getWinnerTeamColor())
            }
            
            GridRow {
                Text("Team")
                    .frame(maxWidth: .infinity)
                
                ForEach(viewModel.getTeams()) { team in
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
                
                ForEach(viewModel.getTeams()) { team in
                    TextField("", value: $viewModel.temporaryInput[team.id], format: .number)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(team.color)
                        .foregroundColor(.white)
                        .focused($selectedTeam, equals: team.id)
                        .onKeyPress { keyPress in
                            if keyPress.key == .space {
                                viewModel.outbid(team: team.id, amount: viewModel.temporaryInput[team.id]!)
                                return .handled
                            }
                            return .ignored
                        }
                }
                
                Text("\(viewModel.getPoolOfMoney())")
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            
            GridRow {
                Text("Auction")
                    .frame(maxWidth: .infinity, minHeight: 44)
                
                ForEach(viewModel.getTeams()) { team in
                    Text("\(viewModel.bidAmount[team.id]!)")
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
            
                ForEach(viewModel.getTeams()) { team in
                    Text("\(viewModel.getBalance(ofTeam: team.id))")
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
        .poweredTouchBar {
            PoweredColorButton(
                identifier: "blueTouchBarButton",
                title: "Niebiescy",
                color: .blue,
                action: {
                    viewModel.selectTeam(.blue)
                    selectedTeam = .blue
                }
            )
            
            PoweredColorButton(
                identifier: "greenTouchBarButton",
                title: "Zieloni",
                color: .green,
                action: {
                    viewModel.selectTeam(.green)
                    selectedTeam = .green
                }
            )
            
            PoweredColorButton(
                identifier: "yellowTouchBarButton",
                title: "Żółci",
                color: .yellow,
                action: {
                    viewModel.selectTeam(.yellow)
                    selectedTeam = .yellow
                }
            )
        }
    }
}
