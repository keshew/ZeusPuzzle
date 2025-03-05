import SwiftUI

class ZeusShopViewModel: ObservableObject {
    let contact = ZeusShopModel()
    @Published var currentIndex = 0
    @Published var dragOffset: CGFloat = 0
    @Published var isDragging = false
    @Published var again = 1
    @Published var userDef = UserDefaultsManager()
}
