import SwiftUI
import PoweredTouchBar

struct PreGameView: View {
    @Bindable private var viewModel = ViewModel()
    
    var body: some View {
        Image("aok")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
