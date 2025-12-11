import SwiftUI

struct QuestionTvView: View {
    private var controller = QuestionController.shared
    
    var body: some View {
        
        if(controller.showSellHint) {
            SellHintSubView(controller: controller)
        }
        else if(controller.showAttachment) {
            ShowAttachment(controller: controller)
        }
        else {
            QuestionSubView(controller: controller)
        }
        
    }
}
