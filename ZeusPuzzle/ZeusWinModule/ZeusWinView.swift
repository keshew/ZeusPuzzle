import SwiftUI

struct ZeusWinView: View {
    @StateObject var zeusWinModel = ZeusWinViewModel()
    @ObservedObject var audioManager = AudioManager.shared
    var score: Int
    var level: Int
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
                
                Image(.zeusShop)
                    .resizable()
                    .frame(width: geometry.size.width + 50, height: geometry.size.height * 0.8)
                    .position(x: geometry.size.width / 1.9, y: geometry.size.height / 1.5)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Image(.roundedSilver)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.374,
                                           height: geometry.size.height * 0.0772)
                                
                                Text("VICTORY")
                                    .UnlockOutline(size: 20)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.025)
                        
                        Spacer(minLength: geometry.size.height * 0.025)
                        
                        HStack(spacing: geometry.size.width * 0.125) {
                            ZStack {
                                Image(.goldBack)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.374,
                                           height: geometry.size.height * 0.0772)
                                
                                VStack(spacing: -5) {
                                    Text("COIN")
                                        .UnlockOutline(size: 14, outlineWidth: 0.5)
                                    
                                    Text("\(UserDefaultsManager.defaults.object(forKey: Keys.money.rawValue) ?? 0)")
                                        .UnlockOutline(size: 26)
                                }
                            }
                            
                            ZStack {
                                Image(.goldBack)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.374,
                                           height: geometry.size.height * 0.0772)
                                
                                VStack(spacing: -5) {
                                    Text("SCORE")
                                        .UnlockOutline(size: 14, outlineWidth: 0.5)
                                    
                                    Text("\(score)")
                                        .UnlockOutline(size: 26)
                                }
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.05)
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Image(.shopBack)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.75,
                                           height: geometry.size.height * 0.29)
                                VStack(spacing: 0) {
                                    Text("With the might of Zeus, you've emerged victorious! Your strategy and skill have triumphed, like a thunderbolt striking down your foes. Celebrate this divine victory and savor the taste of triumph.")
                                        .UnlockOutline(size: 16)
                                        .frame(width: geometry.size.width * 0.625,
                                               height: geometry.size.height * 0.19)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("NEW FACT OPENED! CHECK IN MENU")
                                        .UnlockOutline(size: 18)
                                        .frame(width: geometry.size.width * 0.625)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.trailing)
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.025)
                        
                        HStack {
                            Spacer()
                            
                            VStack(spacing: geometry.size.height * 0.025) {
                                if UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) != 12 {
                                    NavigationLink(destination: ZeusGameView(level: level + 1)) {
                                        Image(.next)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1)
                                    }
                                }
                                
                                
                                NavigationLink(destination: ZeusMenuView()) {
                                    Image(.home)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1)
                                }
                            }
                            .padding(.trailing)
                        }
                    }
                }
            }
            .onAppear() {
                audioManager.playWinMusic()
                audioManager.stopBackgroundMusic()
            }
            
            .onDisappear {
                audioManager.playBackgroundMusic()
                audioManager.stopWinMusic()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusWinView(score: 1000, level: 1)
}
