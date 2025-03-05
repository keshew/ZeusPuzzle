import SwiftUI

class ZeusMenuViewModel: ObservableObject {
    let contact = ZeusMenuModel()
    @Published var again = 0
}
