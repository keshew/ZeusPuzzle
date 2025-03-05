import SwiftUI

class ZeusSettingsViewModel: ObservableObject {
    let contact = ZeusSettingsModel()
    @Published var sliderValue = 5.0
    @Published var soundValue = 5.0
}
