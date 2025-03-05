import SwiftUI

class ZeusGameViewModel: ObservableObject {
    let contact = ZeusGameModel()

    func createZeusGameScene(gameData: ZeusGameData, level: Int) -> ZeusGameSpriteKit {
        let scene = ZeusGameSpriteKit(level: level)
        scene.game  = gameData
        return scene
    }
}
