import SwiftUI

struct ReelTvView: View {
    
    @Bindable private var controller = ReelController.shared
    
    var body: some View {
        VStack {
            Spinner()
        }
    }
}
