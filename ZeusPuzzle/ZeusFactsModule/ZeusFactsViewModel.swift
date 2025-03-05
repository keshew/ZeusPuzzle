import SwiftUI

class ZeusFactsViewModel: ObservableObject {
    let contact = ZeusFactsModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    @Published var isDragging = false
}
