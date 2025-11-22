import SwiftUI
import PoweredTouchBar

struct AuctionTvView: View {
    private let auctionController = AuctionController.shared
    
    var body: some View {
        let teams = auctionController.getTeams()
        
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Text("LICYTACJA")
                    .font(.system(size: auctionController.tvFontSize, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .gridCellColumns(4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(team.color)
                }
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("\(auctionController.getBid(ofTeam: team.id))")
                        .font(Font.custom("LED counter 7", size: auctionController.tvFontSize))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.headline)
                        .background(team.color)
                        .foregroundColor(auctionController.getWinnerTeamColor() == team.color ? Color(r: 196, g: 209, b: 79) : Color.white)
                }
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(team.color)
                }
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("Stan konta")
                        .font(.system(size: auctionController.tvFontSize, weight: .bold))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(team.color)
                        .background(Color.black)
                }
                
                Text("Pula")
                    .font(.system(size: auctionController.tvFontSize, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color(r: 137, g: 71, b: 80))
                    .background(Color.black)
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(team.color)
                }
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("\(auctionController.getBalance(ofTeam: team.id))")
                        .font(Font.custom("LED counter 7", size: auctionController.tvFontSize))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(team.color)
                }
                
                Text("\(auctionController.getPoolOfMoney())")
                    .font(Font.custom("LED counter 7", size: auctionController.tvFontSize))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color.white)
                    .background(Color.black)
            }
            
            GridRow {
                ForEach(teams) { team in
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(team.color)
                }
            }
        }
        .background(Color.black)
    }
}
