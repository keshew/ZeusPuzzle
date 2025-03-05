import SwiftUI

struct ZeusShopView: View {
    @StateObject var zeusShopModel = ZeusShopViewModel()
    @Environment(\.presentationMode) var presentationMode
    
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
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.44)
                
                Image(.bottomShadow)
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.back)
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                            
                            Image(.shopLabel)
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
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Image(.shopBack)
                                    .resizable()
                                    .frame(width: geometry.size.width - geometry.size.width * 0.25, height: geometry.size.height * 0.5)
                                
                                VStack(spacing: geometry.size.height * 0.025) {
                                    Text("ADDITIONAL TIME")
                                        .UnlockOutline(size: 24)
                                    
                                    HStack {
                                        Image(zeusShopModel.contact.bonusImage[zeusShopModel.currentIndex])
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.175, height: geometry.size.width * 0.175)
                                        
                                        Text("X 1")
                                            .UnlockOutline(size: 35)
                                    }
                                    
                                    Text(zeusShopModel.contact.deskBonus[zeusShopModel.currentIndex])
                                        .UnlockOutline(size: 20)
                                        .multilineTextAlignment(.center)
                                        .frame(height: geometry.size.height * 0.125)
                                    
                                    Text("Cost:30 coins")
                                        .UnlockOutline(size: 16)
                                }
                                
                                Button(action: {
                                    if zeusShopModel.currentIndex == 0 {
                                        zeusShopModel.userDef.buyBonus(key: Keys.timeCount.rawValue)
                                    } else {
                                        zeusShopModel.userDef.buyBonus(key: Keys.clueCount.rawValue)
                                    }
                                    zeusShopModel.again = 0
                                }) {
                                    ZStack {
                                        Image(.blueBackButton)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.6,
                                                   height: geometry.size.height * 0.1)
                                        
                                        Text("BUY")
                                            .UnlockOutline(size: 35)
                                    }
                                }
                                .offset(y: geometry.size.height * 0.24)
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
                        zeusShopModel.dragOffset = value.translation.width
                        zeusShopModel.isDragging = true
                    })
                    .onEnded({ value in
                        if abs(value.translation.width) > 50 {
                            if value.translation.width > 0 {
                                if zeusShopModel.currentIndex > 0 {
                                    zeusShopModel.currentIndex -= 1
                                }
                            } else {
                                if zeusShopModel.currentIndex < zeusShopModel.contact.bonusImage.count - 1 {
                                    zeusShopModel.currentIndex += 1
                                }
                            }
                        }
                        zeusShopModel.dragOffset = 0
                        zeusShopModel.isDragging = false
                    })
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusShopView()
}
