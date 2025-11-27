//import SwiftUI
//
//// MARK: - Główny Widok (Zmieniamy na nową logikę)
//struct SpinnerTest: View {
//    
//    let categories = [
//        "Matematyka", "Mity i dzieje starożytne", "Fizyka",
//        "Chemia Organiczna", "Historia Sztuki", "Geografia",
//        "Informatyka", "Biologia", "Literatura Piękna"
//    ]
//    
//    @State private var selectedCategory: String? = nil
//    @State private var isSpinning = false
//    
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            
//            VStack {
//                Text(selectedCategory ?? " ")
//                    .font(.largeTitle.bold())
//                    .foregroundColor(selectedCategory == nil ? .gray : .yellow)
//                    .padding(.top, 20)
//
//                // --- Koło Losujące ---
//                WheelView(
//                    categories: categories,
//                    isSpinning: $isSpinning,
//                    onCategorySelected: { category in
//                        self.selectedCategory = category
//                    }
//                )
//                // Stała wysokość i czarne tło
//                .frame(height: 300)
//                .background(Color.black)
//                .cornerRadius(10)
//                .shadow(color: .yellow.opacity(0.5), radius: 5)
//                
//                Spacer()
//                
//                // Przycisk Zakręć Kołem
//                Button("Zakręć Kołem!") {
//                    selectedCategory = nil
//                    isSpinning = true
//                }
//                .font(.title2.bold())
//                .padding(.horizontal, 40)
//                .padding(.vertical, 15)
//                .background(isSpinning ? Color.gray : Color.blue)
//                .foregroundColor(.white)
//                .clipShape(Capsule())
//                .disabled(isSpinning)
//                .padding(.bottom, 30)
//            }
//        }
//    }
//}
//
//struct WheelView: View {
//    let categories: [String]
//    @Binding var isSpinning: Bool
//    let onCategorySelected: (String) -> Void
//    
//    let itemHeight: CGFloat = 80 // Wysokość elementu
//    @State private var offset: CGFloat = 0
//    
//    var repeatedCategories: [String] {
//        Array(repeating: categories, count: 100).flatMap { $0 }
//    }
//    var centralStartIndex: Int {
//        categories.count * 50
//    }
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 0) {
//                        ForEach(repeatedCategories.indices, id: \.self) { index in
//                            CategoryRow(
//                                text: repeatedCategories[index],
//                                height: itemHeight,
//                                isSelected: isElementSelected(index: index, viewHeight: geometry.size.height) // Dodajemy wysokość widoku
//                            )
//                        }
//                    }
//                    .offset(y: offset)
//                }
//                .contentShape(Rectangle())
//                .clipped()
//                .onChange(of: isSpinning) { newValue in
//                    if newValue {
//                        startSpinning(viewHeight: geometry.size.height) // Dodajemy wysokość widoku
//                    }
//                }
//                
//                WheelIndicator(itemHeight: itemHeight)
//            }
//        }
//    }
//    
//    // MARK: - Logika Zaznaczenia (DOSTOSOWANA DO WYSOKOŚCI WIDOKU!)
//    
//    func isElementSelected(index: Int, viewHeight: CGFloat) -> Bool {
//        guard !isSpinning else { return false }
//        
//        // 1. Definicja Pozycji Wskaźnika (Względna do góry VStacka)
//        // Wskaźnik znajduje się na wysokości: (cała wysokość widoku / 2)
//        let indicatorPosition = viewHeight / 2.0
//        
//        // 2. Obliczamy punkt centralny dla elementu (Względny do góry VStacka)
//        let elementTop = CGFloat(index) * itemHeight
//        let elementBottom = elementTop + itemHeight
//        
//        // 3. Wskaźnik wskazuje na dany element, jeśli:
//        // Wskaźnik jest PONIŻEJ góry elementu ORAZ Wskaźnik jest POWYŻEJ dołu elementu.
//        // ALE: Musimy uwzględnić globalny offset!
//        
//        // Pozycja elementu po przesunięciu:
//        let elementTopAfterOffset = elementTop + offset
//        let elementBottomAfterOffset = elementBottom + offset
//        
//        // Sprawdzamy, czy środek widoku (indicatorPosition) mieści się w zakresie elementu
//        return indicatorPosition >= elementTopAfterOffset && indicatorPosition <= elementBottomAfterOffset
//    }
//    
//    // MARK: - Animacja (DOSTOSOWANA DO WYSOKOŚCI WIDOKU!)
//    
//    func startSpinning(viewHeight: CGFloat) {
//        let winningIndex = categories.indices.randomElement() ?? 0
//        let minimumTurns = 5
//        let baseIndex = centralStartIndex + winningIndex + (categories.count * minimumTurns)
//        
//        let offsetToElementTop = -(CGFloat(baseIndex) * itemHeight)
//        let offsetCorrection = (viewHeight / 2.0) - (itemHeight / 2.0)
//        let targetOffset = offsetToElementTop + offsetCorrection
//        
//        let randomDrift = CGFloat.random(in: -itemHeight/4...itemHeight/4)
//        let finalOffset = targetOffset + randomDrift
//        
//        self.offset = -(CGFloat(centralStartIndex) * itemHeight) + offsetCorrection
//        self.isSpinning = true
//        
//        withAnimation(.timingCurve(
//            0.1, 0.7, 0.4, 1.0,
//            duration: Double.random(in: 6.0...10.0)
//        )) {
//            self.offset = finalOffset
//        } completion: {
//            self.offset = finalOffset
//            self.isSpinning = false
//            onCategorySelected(categories[winningIndex])
//        }
//    }
//}
//struct WheelIndicator: View {
//    let itemHeight: CGFloat
//    
//    var body: some View {
//        ZStack {
//            HStack {
//                TriangleShape()
//                    .fill(Color.black)
//                    .frame(width: 200, height: 50)
//                    .rotationEffect(.degrees(90))
//                    .offset(x: -80)
//                
//                Spacer()
//                
//                TriangleShape()
//                    .fill(Color.black)
//                    .frame(width: 200, height: 50)
//                    .rotationEffect(.degrees(-90))
//                    .offset(x: 80)
//            }
//            
//            
//        }
//        .frame(height: itemHeight)
//        .allowsHitTesting(false)
//    }
//}
//
//// MARK: - Komponenty Wizualne
//
//struct CategoryRow: View {
//    let text: String
//    let height: CGFloat
//    let isSelected: Bool
//    
//    var body: some View {
//        Text(text)
//            .font(.title2.bold())
//            .foregroundColor(isSelected ? .black : .white)
//            .frame(height: height)
//            .frame(maxWidth: .infinity)
//            .background(isSelected ? Color.yellow : Color.gray.opacity(0.6))
//            .border(Color.black, width: 1)
//    }
//}
//
//struct TriangleShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//        return path
//    }
//}
//
//#Preview {
//    SpinnerTest()
//}
