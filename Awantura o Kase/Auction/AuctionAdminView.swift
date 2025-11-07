import SwiftUI
import PoweredTouchBar

struct AuctionAdminView: View {
    @Bindable private var viewModel = ViewModel()
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
                
                Text("Niebiescy")
                    .bold()
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    
                Text("Zieloni")
                    .bold()
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.green)
                
                Text("Żółci")
                    .bold()
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.yellow)
                
                Text("Pula")
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            
            GridRow {
                Text("Auction input")
                    .frame(maxWidth: .infinity, minHeight: 44)
            
                
                TextField("Enter your score", value: $viewModel.temporaryInput[.blue], format: .number)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .focused($selectedTeam, equals: .blue)
                    .onKeyPress { keyPress in
                                if keyPress.key == .space {
                                    viewModel.outbid(team: .blue, amount: viewModel.temporaryInput[.blue]!)
                                    return .handled
                                }
                                return .ignored
                            }
                
                TextField("Enter your score", value: $viewModel.temporaryInput[.green], format: .number)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .focused($selectedTeam, equals: .green)
                    .onKeyPress { keyPress in
                                if keyPress.key == .space {
                                    viewModel.outbid(team: .green, amount: viewModel.temporaryInput[.green]!)
                                    return .handled
                                }
                                return .ignored
                            }
                
                TextField("Enter your score", value: $viewModel.temporaryInput[.yellow], format: .number)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.yellow)
                    .focused($selectedTeam, equals: .yellow)
                    .onKeyPress { keyPress in
                                if keyPress.key == .space {
                                    viewModel.outbid(team: .yellow, amount: viewModel.temporaryInput[.yellow]!)
                                    return .handled
                                }
                                return .ignored
                            }
                
                Text("\(viewModel.getPoolOfMoney())")
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            
            GridRow {
                Text("Auction")
                    .frame(maxWidth: .infinity, minHeight: 44)
                
                Text("\(viewModel.bidAmount[.blue]!)")
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                
                Text("\(viewModel.bidAmount[.green]!)")
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                
                Text("\(viewModel.bidAmount[.yellow]!)")
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.yellow)
                
                Text("Pula Admina:")
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            
            GridRow {
                Text("Stan Konta")
                    .frame(maxWidth: .infinity, minHeight: 44)
            
                
                Text("\(viewModel.getBalance(ofTeam: .blue))")
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                
                Text("\(viewModel.getBalance(ofTeam: .green))")
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                
                Text("\(viewModel.getBalance(ofTeam: .yellow))")
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.yellow)
                
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
