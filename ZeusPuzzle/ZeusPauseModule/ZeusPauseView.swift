import SwiftUI
import SpriteKit

struct ZeusPauseView: View {
    @StateObject var zeusPauseModel = ZeusPauseViewModel()
    var game: ZeusGameData
    var scene: SKScene
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.settingsBack)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(.topShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 9)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                game.isPause = false
                                scene.isPaused = false
                            }) {
                                Image(.back)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.15,
                                           height: geometry.size.width * 0.15)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                            
                            Image(.pause)
                                .resizable()
                                .frame(width: geometry.size.width * 0.37, height: geometry.size.height * 0.0772)
                                .padding(.trailing, geometry.size.width * 0.2)
                            
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.025)
                        
                        Spacer(minLength: geometry.size.height * 0.05)
                        
                        ZStack {
                            Image(.goldBack)
                                .resizable()
                                .frame(width: geometry.size.width * 0.374, height: geometry.size.height * 0.0772)
                            
                            VStack(spacing: -5) {
                                Text("COIN")
                                    .UnlockOutline(size: 14, outlineWidth: 0.5)
                                
                                Text("\(UserDefaultsManager.defaults.object(forKey: Keys.money.rawValue) ?? 0)")
                                    .UnlockOutline(size: 26)
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.05)
                        
                        ZStack {
                            Image(.shopBack)
                                .resizable()
                                .frame(width: geometry.size.width * 0.875, height: geometry.size.height * 0.31)
                            
                            Text("When the game is paused, it's like Zeus has granted you a moment of divine respite. Use this time to strategize, recharge, and return with the might of a thunderbolt.")
                                .UnlockOutline(size: 19)
                                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.29)
                                .lineSpacing(6)
                                .multilineTextAlignment(.center)
                            
                            VStack(spacing: geometry.size.height * 0.025) {
                                Button(action: {
                                    game.isPause = false
                                    scene.isPaused = false
                                }) {
                                    Image(.continueButton)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1)
                                }
                                
                                NavigationLink(destination: ZeusMenuView()) {
                                    Image(.home)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1)
                                }
                            }
                            .offset(y: geometry.size.height * 0.24)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let game = ZeusGameData()
    ZeusPauseView(game: game, scene: game.scene)
}
