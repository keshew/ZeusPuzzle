import SwiftUI

@main
struct ZeusPuzzleApp: App {
    @ObservedObject var audioManager = AudioManager.shared
    var body: some Scene {
        WindowGroup {
            ZeusMenuView()
                .onAppear() {
                    UserDefaultsManager().firstLaunch()
                    audioManager.playBackgroundMusic()
                    
                }
        }
    }
}
