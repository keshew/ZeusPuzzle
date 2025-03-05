import SwiftUI

struct ZeusMenuView: View {
    @StateObject var zeusMenuModel = ZeusMenuViewModel()
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image(.menuBack)
                        .resizable()
                        .ignoresSafeArea()
                    
                    Image(.zeusMenu)
                        .resizable()
                        .frame(width: geometry.size.width + 50, height: geometry.size.height * 0.85)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 1.62)
                    
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
                            HStack(spacing: geometry.size.width * 0.075) {
                                NavigationLink(destination: ZeusSettingsView()) {
                                    VStack(spacing: geometry.size.height * 0.00625) {
                                        Image(.settings)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.175)
                                            .offset(y: -geometry.size.height * 0.0025)
                                        Text("SETTINGS")
                                            .UnlockOutline(size: 20)
                                    }
                                }
                                
                                NavigationLink(destination: ZeusFactsView()) {
                                    VStack(spacing: geometry.size.height * 0.0125) {
                                        Image(.facts)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.1625)
                                        
                                        Text("FACTS")
                                            .UnlockOutline(size: 20)
                                    }
                                }
                                
                                NavigationLink(destination: ZeusShopView()) {
                                    VStack(spacing: geometry.size.height * 0.0125) {
                                        Image(.shop)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.1625)
                                        
                                        Text("SHOP")
                                            .UnlockOutline(size: 20)
                                    }
                                }
                            }
                            .padding(.top, geometry.size.height * 0.05)
                            
                            Spacer(minLength: geometry.size.height * 0.5)
                            
                            VStack(spacing: geometry.size.height * 0.025) {
                                NavigationLink(destination: ZeusLevelView()) {
                                    ZStack {
                                        Image(.silverBack)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.55, height: geometry.size.height * 0.1)
                                        
                                        Text("PLAY")
                                            .UnlockOutline(size: 46)
                                    }
                                }
                                
                                ZStack {
                                    Image(.goldBack)
                                        .resizable()
                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.088)
                                    
                                    VStack(spacing: -5) {
                                        Text("COIN")
                                            .UnlockOutline(size: 14, outlineWidth: 0.5)
                                        
                                        Text("\(UserDefaultsManager.defaults.object(forKey: Keys.money.rawValue) ?? 0)")
                                            .UnlockOutline(size: 26)
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear() {
                    zeusMenuModel.again = 1
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ZeusMenuView()
}
