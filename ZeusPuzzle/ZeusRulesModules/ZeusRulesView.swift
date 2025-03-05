import SwiftUI
import SpriteKit

struct ZeusRulesView: View {
    @StateObject var zeusRulesModel = ZeusRulesViewModel()
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
                            Button(action: {
                                game.isRules = false
                                scene.isPaused = false
                            }) {
                                Image(.back)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Image(.roundedSilver)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.374, height: geometry.size.height * 0.0772)
                                  
                                Text("RULES")
                                    .UnlockOutline(size: 20)
                            }
                            .padding(.trailing, geometry.size.width * 0.2)
                            
                            Spacer()
                        }
                        .padding(.top, geometry.size.height * 0.025)
                        
                        Spacer(minLength: geometry.size.height * 0.18)
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Image(.shopBack)
                                    .resizable()
                                    .frame(width: geometry.size.width - geometry.size.width * 0.25, height: geometry.size.height * 0.5)
                                  
                                Text(zeusRulesModel.contact.textArray[zeusRulesModel.currentIndex])
                                    .UnlockOutline(size: 28)
                                    .multilineTextAlignment(.center)
                                    .frame(width: geometry.size.width - geometry.size.width * 0.425, height: geometry.size.height * 0.48)
                            }
                            .padding(.trailing)
                        }
                        
                        Spacer(minLength: geometry.size.height * 0.11)
                        Text("SWIPE LEFT\\RIGHT to NEXT\\PREV PAGE")
                            .UnlockOutline(size: 25)
                    }
                }
            }
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged({ value in
                        zeusRulesModel.dragOffset = value.translation.width
                        zeusRulesModel.isDragging = true
                    })
                    .onEnded({ value in
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                if zeusRulesModel.currentIndex > 0 {
                                    zeusRulesModel.currentIndex -= 1
                                }
                            } else {
                                if zeusRulesModel.currentIndex < zeusRulesModel.contact.textArray.count - 1 {
                                    zeusRulesModel.currentIndex += 1
                                }
                            }
                        }
                        zeusRulesModel.dragOffset = 0
                        zeusRulesModel.isDragging = false
                    })
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let model = ZeusGameData()
    ZeusRulesView(game: model, scene: model.scene)
}
