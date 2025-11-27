import SwiftUI

struct SingleReelSlotView: View {
    let categories: [String]

        private let itemHeight: CGFloat = 60
        private let reelCopies = 50

        @State private var offset: CGFloat = 0
        @State private var isSpinning = false
        @State private var result: String? = nil
        @State private var disableButton = false

        init(categories: [String]) {
            self.categories = categories.isEmpty ? ["—"] : categories
        }

        var body: some View {
            VStack(spacing: 20) {

                ZStack {
                    reelView()
                        .frame(width: 500, height: itemHeight * 3)
                        .clipped()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.black.opacity(0.8))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.white.opacity(0.25), lineWidth: 2)
                        )

                    // 🔴 Czerwona linia wskazania
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: 3)
                }

                Button(action: spin) {
                    Text(isSpinning ? "Kręci…" : "Spin")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(disableButton ? Color.gray.opacity(0.5) : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(disableButton)
                .padding(.horizontal)

                if let result {
                    Text("Wylosowano: \(result)")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                } else {
                    Text("")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .onAppear {
                let randomIndex = Int.random(in: 0..<categories.count)
                offset = -CGFloat(randomIndex) * itemHeight
            }
        }

        // MARK: – nieskończony bęben
        private func reelView() -> some View {
            let repeated = Array(repeating: categories, count: reelCopies).flatMap { $0 }
            let totalHeight = CGFloat(repeated.count) * itemHeight

            return VStack(spacing: 0) {
                ForEach(repeated.indices, id: \.self) { idx in
                    let baseIndex = idx % categories.count

                    // 🌑 Ciemna skala szarości
                    let bg = baseIndex.isMultiple(of: 2)
                        ? Color(white: 0.15)
                        : Color(white: 0.25)

                    Text(repeated[idx])
                        .frame(height: itemHeight)
                        .frame(maxWidth: .infinity)
                        .background(bg)
                        .foregroundColor(.white)
                }
            }
            .offset(y: wrapped(offset, within: totalHeight))
        }

        private func wrapped(_ value: CGFloat, within total: CGFloat) -> CGFloat {
            let m = total
            let v = value.truncatingRemainder(dividingBy: m)
            return v > 0 ? v - m : v
        }

        // MARK: – SPIN (z idealnym centrowaniem)
        private func spin() {
            guard !isSpinning else { return }

            isSpinning = true
            disableButton = true
            result = nil

            // indeks kategorii, która ma się zatrzymać dokładnie na linii
            let finalIndex = Int.random(in: 0..<categories.count)

            // liczba pełnych obrotów
            let spins = Int.random(in: 10...18)

            // ⛔ UWAGA: Zawsze trafiamy idealnie w środek elementu
            let targetOffset =
                offset
                - CGFloat(spins * categories.count + finalIndex) * itemHeight

            withAnimation(.easeOut(duration: 2.6)) {
                offset = targetOffset
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.65) {
                // Normalizacja (bez skoków)
                offset = -CGFloat(finalIndex) * itemHeight

                result = categories[finalIndex]
                isSpinning = false
                disableButton = false
            }
        }
}


struct SingleReelSlotView_Previews: PreviewProvider {
    static var previews: some View {
        SingleReelSlotView(categories: [
            "Sport", "Kultura", "Nauka", "Film", "Technologia"
        ])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
