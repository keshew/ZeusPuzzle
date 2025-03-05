import SwiftUI

struct ZeusLoseView: View {
    @StateObject var zeusLoseModel = ZeusLoseViewModel()
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
                                    .frame(width: geometry.size.width * 0.374, height: geometry.size.height * 0.0772)
                                
                                Text("GAME OVER")
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
                                    .frame(width: geometry.size.width * 0.374, height: geometry.size.height * 0.0772)
                                
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
                                    .frame(width: geometry.size.width * 0.374, height: geometry.size.height * 0.0772)
                                
                                VStack(spacing: -5) {
                                    Text("SCORE")
                                        .UnlockOutline(size: 14, outlineWidth: 0.5)
                                    
                                    Text("\(score)")
                                        .UnlockOutline(size: 26)
                                }
                            }
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.08)
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Image(.shopBack)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.29)
                               
                                Text("Even the mighty Zeus faces setbacks. Though defeat stings, use this moment to learn and grow stronger. Reflect on your strategies, regroup, and prepare to return with renewed determination and the power of a storm.")
                                    .UnlockOutline(size: 18)
                                    .frame(width: geometry.size.width * 0.625, height: geometry.size.height * 0.25)
                                    .lineSpacing(0)
                                    .multilineTextAlignment(.center)
                                  
                            }
                            .padding(.trailing)
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.05)
                        
                        HStack {
                            Spacer()
                            
                            VStack(spacing: geometry.size.height * 0.025) {
                                NavigationLink(destination: ZeusGameView(level: level)) {
                                    Image(.restart)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.1)
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
                audioManager.playLoseMusic()
                audioManager.stopBackgroundMusic()
            }
            
            .onDisappear {
                audioManager.playBackgroundMusic()
                audioManager.stopLoseMusic()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusLoseView(score: 1000, level: 1)
}
