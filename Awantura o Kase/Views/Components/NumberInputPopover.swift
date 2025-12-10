import SwiftUI

struct NumberInputPopover: View {
    @State private var value: String = ""
    var message: String
    var onConfirm: (Int) -> Void
    var onAppear: () -> Void = {}
    var onCancel: () -> Void = {}
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(message)
                .font(.headline)
            
            TextField("amount", text: $value)
                .textFieldStyle(.roundedBorder)
                .frame(width: 200)
            
            HStack {
                Spacer()
                Button("Cancel") {
                    onCancel()
                    dismiss()
                }
                Button("OK") {
                    if let number = Int(value) {
                        onConfirm(number)
                    }
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(16)
        .onAppear {
            onAppear()
        }
    }
}
