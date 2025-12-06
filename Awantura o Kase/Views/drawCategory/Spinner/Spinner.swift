import SwiftUI

// MARK: - Główny Widok (Zmieniamy na nową logikę)
struct Spinner: View {
    
    @Bindable private var controller = ReelController.shared
    
    var body: some View {
        VStack {
            WheelView(
                categories: controller.getCategories(),
                isSpinning: $controller.isSpinning,
                onCategorySelected: { category in
                    controller.selectedCategory = category
                }
            )
            .frame(height: 300)
            .background(Color.black)
            .cornerRadius(10)
            .shadow(color: .yellow.opacity(0.5), radius: 5)
        }
    }
}

struct WheelView: View {
    @Bindable private var controller = ReelController.shared
    
    let categories: [String]
    @Binding var isSpinning: Bool
    let onCategorySelected: (String) -> Void
    
    let itemHeight: CGFloat = 80
    @State private var offset: CGFloat = 0
    
    var repeatedCategories: [String] {
        Array(repeating: categories, count: 100).flatMap { $0 }
    }
    var centralStartIndex: Int {
        categories.count * 50
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(repeatedCategories.indices, id: \.self) { index in
                            CategoryRow(
                                text: repeatedCategories[index],
                                height: itemHeight,
                                isSelected: isElementSelected(index: index, viewHeight: geometry.size.height) // Dodajemy wysokość widoku
                            )
                        }
                    }
                    .offset(y: offset)
                }
                .contentShape(Rectangle())
                .clipped()
                .onChange(of: isSpinning) { newValue in
                    if newValue {
                        startSpinning(viewHeight: geometry.size.height)
                    }
                }
                
                WheelIndicator(itemHeight: itemHeight)
            }
        }
    }
    
    // MARK: - Logika Zaznaczenia (DOSTOSOWANA DO WYSOKOŚCI WIDOKU!)
    
    func isElementSelected(index: Int, viewHeight: CGFloat) -> Bool {
        guard !isSpinning else { return false }
        
        let indicatorPosition = viewHeight / 2.0
        
        let elementTop = CGFloat(index) * itemHeight
        let elementBottom = elementTop + itemHeight

        let elementTopAfterOffset = elementTop + offset
        let elementBottomAfterOffset = elementBottom + offset
        
        return indicatorPosition >= elementTopAfterOffset && indicatorPosition <= elementBottomAfterOffset
    }
    
    // MARK: - Animacja (DOSTOSOWANA DO WYSOKOŚCI WIDOKU!)
    func startSpinning(viewHeight: CGFloat) {
        let winningIndex = controller.getWinningIndex()
        
        let minimumTurns = 20
        
        let baseIndex = centralStartIndex + winningIndex + (categories.count * minimumTurns)
        
        let offsetToElementTop = -(CGFloat(baseIndex) * itemHeight)
        let offsetCorrection = (viewHeight / 2.0) - (itemHeight / 2.0)
        let targetOffset = offsetToElementTop + offsetCorrection
        
        let randomDrift = CGFloat.random(in: -itemHeight/4...itemHeight/4)
        let finalOffset = targetOffset + randomDrift
        
        self.offset = -(CGFloat(centralStartIndex) * itemHeight) + offsetCorrection
        self.isSpinning = true
        
        withAnimation(.timingCurve(
            0.1, 0.7, 0.4, 1.0,
            duration: 13
        )) {
            self.offset = finalOffset
        } completion: {
            self.offset = finalOffset
            self.isSpinning = false
            controller.resetWinningIndex()
            
            
            // Placeholder for saving drafted category
        }
    }
}

struct WheelIndicator: View {
    let itemHeight: CGFloat
    
    var body: some View {
        ZStack {
            HStack {
                TriangleShape()
                    .fill(Color.black)
                    .frame(width: 200, height: 50)
                    .rotationEffect(.degrees(90))
                    .offset(x: -80)
                
                Spacer()
                
                TriangleShape()
                    .fill(Color.black)
                    .frame(width: 200, height: 50)
                    .rotationEffect(.degrees(-90))
                    .offset(x: 80)
            }
        }
        .frame(height: itemHeight)
        .allowsHitTesting(false)
    }
}

// MARK: - Komponenty Wizualne

struct CategoryRow: View {
    let text: String
    let height: CGFloat
    let isSelected: Bool
    
    var body: some View {
        Text(text)
            .font(Font.custom("Windows Dots", size: 40))
            .foregroundColor(isSelected ? .black : .white)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.yellow : Color.gray.opacity(0.6))
            .border(Color.black, width: 1)
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

#Preview {
    Spinner()
}
