import SwiftUI

struct MyHeader: View {
    @State var header: String = ""
    
    var body: some View {
        
        HStack {
            Text(header)
                .font(Font.custom("LED counter 7", size: 40))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .bold()
                .font(.headline)
                .foregroundColor(Color.accentColor)
            
            Spacer()
        }
    }
}
