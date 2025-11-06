import SwiftUI
import PoweredTouchBar

struct AuctionAdminView: View {
    @Environment(GameController.self) private var gameController
    
    @State private var tempBlue = 0
    @State private var tempGreen = 0
    @State private var tempYellow = 0
    
    @FocusState private var focusedField: TeamColor?
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            GridRow {
                Text("Winner")
                    .gridCellColumns(5)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.pink)
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
            
                
                TextField("Enter your score", value: $tempBlue, format: .number)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .focused($focusedField, equals: .blue)
                
                TextField("Enter your score", value: $tempGreen, format: .number)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .focused($focusedField, equals: .green)
                
                TextField("Enter your score", value: $tempYellow, format: .number)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.yellow)
                    .focused($focusedField, equals: .yellow)
                
                Text("")
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
        }
        .poweredTouchBar {
            PoweredColorButton(
                identifier: "blueTouchBarButton",
                title: "Niebiescy",
                color: .blue,
                action: {
                    print("Przycisk został naciśnięty!")
                    focusedField = .blue
                }
            )
            
            PoweredColorButton(
                identifier: "greenTouchBarButton",
                title: "Zieloni",
                color: .green,
                action: {
                    print("Przycisk został naciśnięty!")
                    focusedField = .green
                }
            )
            
            PoweredColorButton(
                identifier: "yellowTouchBarButton",
                title: "Żółci",
                color: .yellow,
                action: {
                    print("Przycisk został naciśnięty!")
                    focusedField = .yellow
                }
            )
        }

    }
}
