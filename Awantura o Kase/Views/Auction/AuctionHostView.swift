import SwiftUI
import PoweredTouchBar
import AppKit

struct AuctionHostView: View {
    @Bindable private var controller = AuctionController.shared
    @Bindable private var gameController: GameController = GameController.shared
    @FocusState private var selectedTeam: TeamColor?
    
    @State var showInspector = true
    @State private var showPenaltyPopover = false
    @State private var showAddPoolPopover = false
    
    var body: some View {
        VStack {
            MyHeader(header: "Auction")
            
            Spacer()
            
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                
                GridRow {
                    Text("\(controller.getWinnerTeamName()) \(controller.getCurrentBind())")
                        .font(.system(size: 20, weight: .bold))
                        .gridCellColumns(5)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(controller.getWinnerTeamColor())
                }
                
                GridRow {
                    Text("")
                    
                    Text(" ")
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .gridCellColumns(3)
                        .frame(maxWidth: .infinity)
                        .background(controller.getSelectedTeamColor())
                    
                    Text("")
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
                    
                    Text("Pool")
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
                    
                    Text("Host pool of money:")
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                
                GridRow {
                    Text("Balance")
                        .frame(maxWidth: .infinity, minHeight: 44)
                
                    ForEach(controller.getTeams()) { team in
                        Text("\(controller.getBalance(ofTeam: team.id))")
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(team.color)
                            .foregroundColor(.white)
                    }
                    
                    Text(String(gameController.getHostPoolOfMoney()))
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                
                GridRow {
                    Text("")
                    
                    Text(" ")
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .gridCellColumns(3)
                        .frame(maxWidth: .infinity)
                        .background(controller.getSelectedTeamColor())
                    
                    Text("")
                }
            }
            
            HStack {
                if(!controller.auctionStarted) {
                    Button("Start Auction", systemImage: "play.fill") {
                        controller.startAuction()
                    }
                }

                Button("imposition of penalty") {
                    showPenaltyPopover = true
                }
                .popover(isPresented: $showPenaltyPopover) {
                    NumberInputPopover(
                        message: "Provide amount for team \(controller.getSelectedTeamName())",
                        onConfirm: { number in
                            controller.givePenalty(amount: number)
                        }
                    )
                    .frame(width: 240)
                }
                
                Button("Increment Pool") {
                    showAddPoolPopover = true
                }
                .popover(isPresented: $showAddPoolPopover) {
                    NumberInputPopover(
                        message: "Provide amount to increese pool",
                        onConfirm: { number in
                            controller.incrementPoolFromHost(amount: number)
                        }
                    )
                    .frame(width: 240)
                }
                
                Button("Vabank") {
                    controller.vabank()
                }
                
                Button("Next stage", systemImage: "arrow.right.square.fill") {
                    gameController.jumpToQuestion()
                }
                
                
            }
            
            Spacer()
        }
        .padding(20)
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
