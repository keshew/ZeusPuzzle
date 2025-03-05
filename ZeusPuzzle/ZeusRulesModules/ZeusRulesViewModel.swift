import SwiftUI

class ZeusRulesViewModel: ObservableObject {
    let contact = ZeusRulesModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    @Published var isDragging = false
}
